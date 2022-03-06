local status_ok, _ = pcall(require, "lspconfig")

if not status_ok then
	return
end

require("matt.lsp.lsp-installer")
require("matt.lsp.handlers").setup()
