local clangd_flags = { "--background-index" }

require"lspconfig".clangd.setup {
  on_attach = require"lsp".common_on_attach,
  cmd = { "clangd", unpack(clangd_flags) },
  handlers = {
    ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = { spacing = 0, prefix = " " },
      signs = true,
      underline = true,
      update_in_insert = true,
    })
  }
}

--[[
require('lv-utils').define_augroups {
  _clang_autoformat = {
    { "BufWritePre *.c lua vim.lsp.buf.formatting_sync(nil, 1000)" },
    { "BufWritePre *.h lua vim.lsp.buf.formatting_sync(nil, 1000)" },
    { "BufWritePre *.cpp lua vim.lsp.buf.formatting_sync(nil, 1000)" },
    { "BufWritePre *.hpp lua vim.lsp.buf.formatting_sync(nil, 1000)" },
  }
}
--]]
