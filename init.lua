-- load all plugins
require "pluginsList"
require "plugins/fileicons"

require "mappings"
require "options"
require "utils"
require "plugins/bufferline"
require "plugins/statusline"

require("colorizer").setup()

-- lsp
require "plugins/compe"

local cmd = vim.cmd
local g = vim.g

-- colorscheme related stuff

cmd "syntax enable"
cmd "syntax on"
g.sonokai_style = "andromeda"
g.sonokai_enable_italic = 1
cmd "colorscheme sonokai"

-- local base16 = require "base16"
-- base16(base16.themes["monokai"], true)

-- blankline
local indent = 2

g.indentLine_enabled = 1
g.indent_blankline_char = "▏"

cmd "hi IndentBlanklineChar guifg=#42464e"

g.indent_blankline_filetype_exclude = {"help", "terminal"}
g.indent_blankline_buftype_exclude = {"terminal"}

g.indent_blankline_show_trailing_blankline_indent = false
g.indent_blankline_show_first_indent_level = false

require("plugins/treesitter")

-- highlights --
cmd "hi LineNr guifg=#42464e guibg=NONE"
cmd "hi Comment guifg=#42464e"

cmd "hi SignColumn guibg=NONE"
cmd "hi VertSplit guibg=NONE guifg=#2a2e36"
cmd "hi EndOfBuffer guifg=#1e222a"
cmd "hi PmenuSel guibg=#98c379"
cmd "hi Pmenu  guibg=#282c34"

-- telescope stuff and popupmenu
require "plugins/telescope"

cmd "hi TelescopeBorder   guifg=#2a2e36"
cmd "hi TelescopePromptBorder   guifg=#2a2e36"
cmd "hi TelescopeResultsBorder  guifg=#2a2e36"
cmd "hi TelescopePreviewBorder  guifg=#525865"

--  nvim tree color for folder name and icon
require "plugins/nvimtree"

cmd "hi NvimTreeFolderIcon guifg = #61afef"
cmd "hi NvimTreeFolderName guifg = #61afef"
cmd "hi NvimTreeIndentMarker guifg=#383c44"

-- cmd "hi Normal guibg=NONE ctermbg=NONE"
cmd "hi Normal ctermbg=NONE"
cmd "hi nonText ctermbg=NONE"

-- git signs
require "plugins/gitsigns"

cmd "hi DiffAdd guifg=#81A1C1 guibg = none"
cmd "hi DiffChange guifg =#3A3E44 guibg = none"
cmd "hi DiffModified guifg = #81A1C1 guibg = none"

require("nvim-autopairs").setup()

require("lspkind").init(
    {
        with_text = true,
        symbol_map = {
            Folder = ""
        }
    }
)

require "lsp_signature".on_attach({
  bind = true,
  floating_window = true,
  handler_opts = {
    border = "single"
  }
})

-- hide line numbers in terminal windows
vim.api.nvim_exec([[
   au BufEnter term://* setlocal nonumber
]], false)

-- inactive statuslines as thin splitlines
cmd("highlight! StatusLineNC gui=underline guibg=NONE guifg=#383c44")

cmd "hi clear CursorLine"
cmd "hi cursorlinenr guibg=NONE guifg=#abb2bf"
