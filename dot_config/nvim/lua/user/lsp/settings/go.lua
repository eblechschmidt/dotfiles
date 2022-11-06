local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

return {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gotmpl" },
  root_dir = lspconfig.util.root_pattern("go.mod", ".git"),
  single_file_support = true,
}
