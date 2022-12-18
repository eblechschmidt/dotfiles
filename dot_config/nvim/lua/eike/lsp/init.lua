local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "eike.lsp.lsp-installer"
require("eike.lsp.handlers").setup()
require "eike.lsp.null-ls"
require "eike.lsp.lsp-signature"

vim.lsp.handlers["textDocument/references"] = require("telescope.builtin").lsp_references

-- auto import for go
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.go" },
	callback = function()
		local params = vim.lsp.util.make_range_params(nil, "utf-16")
		params.context = { only = { "source.organizeImports" } }
		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
		for _, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.edit then
					vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
				else
					vim.lsp.buf.execute_command(r.command)
				end
			end
		end
	end,
})

-- gofmt
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.go" },
	callback = function()
		vim.lsp.buf.formatting_sync(nil, 500)
	end,
})
