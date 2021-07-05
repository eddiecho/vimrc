local lsp = require'lsp'

local root_files = {
  "package.json",
  "tsconfig.json",
  "jsconfig.json",
  ".git"
}

local function on_attach(client, bufnr)
  client.resolved_capabilities.document_formatting = false
  local ts_utils = require"nvim-lsp-ts-utils"

  ts_utils.setup {
    debug = false,
    disable_commands = false,
    enable_import_on_completion = true,
    import_all_timeout = 2000,

    eslint_enable_code_actions = true,
    eslint_enable_disable_comments = true,
    eslint_bin = "eslint",
    eslint_config_fallback = nil,
    eslint_enable_diagnostics = true,

    enable_formatting = true,
    formatter = "prettier",
    formatter_config_fallback = nil,

    complete_parens = false,
    signature_help_in_parens = false,

    update_imports_on_move = false,
    require_confirmation_on_move = false,
    watch_dir = nil,
  }

  ts_utils.setup_client(client)
end

require"lspconfig".tsserver.setup {
  cmd = {"typescript-language-server", "--stdio"},
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  settings = { documentFormatting = false },
  root_dir = lsp.root_dir(root_files),
  on_attach = on_attach,
  handlers = {
    ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = { spacing = 0, prefix = " "},
      signs = true,
      underline = true,
      update_in_insert = true
    })
  }
}

vim.cmd "setl ts=2 sw=2"
