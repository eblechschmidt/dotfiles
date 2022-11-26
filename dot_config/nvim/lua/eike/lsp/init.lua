local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

-- require "user.lsp.lsp-signature"
require "eike.lsp.lsp-installer"
require("eike.lsp.handlers").setup()
require "eike.lsp.null-ls"

vim.cmd[[autocmd BufWritePre *.go lua vim.lsp.buf.formatting()]]
