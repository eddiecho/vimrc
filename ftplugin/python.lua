local lsp_config = require'lspconfig'

local root_files = {
  "setup.py",
  "pyproject.toml",
  "setup.cfg",
  "requirements.txt",
  ".git",
}

-- npm i -g pyright
lsp_config.pyright.setup {
    cmd = {
        "pyright-langserver",
        "--stdio"
    },
    filetypes = { "python" },
    root_dir = function(filename)
      return lsp_config.util.root_pattern(unpack(root_files))(filename) or lsp_config.util.path.dirname(filename)
    end,
    on_attach = require'lsp'.common_on_attach,
    handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic
                                                               .on_publish_diagnostics,
                                                           {
            virtual_text = {spacing = 0, prefix = " "},
            signs = true,
            underline = true,
            update_in_insert = true
        })
    },
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
            }
        }
    }
}

--[[
if O.lang.python.autoformat then
    require('lv-utils').define_augroups({
        _python_autoformat = {
            {
                'BufWritePre', '*.py',
                'lua vim.lsp.buf.formatting_sync(nil, 1000)'
            }
        }
    })
end
--]]
