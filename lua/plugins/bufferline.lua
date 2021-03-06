vim.o.termguicolors = true

require "bufferline".setup {
    options = {
        numbers = "buffer_id",
        number_style = "superscript",
        mappings = true,
        buffer_close_icon = "✗",
        offsets = {{filetype = "NvimTree", text = "Explorer", highlight = "Directory" }},
        modified_icon = "●",
        close_icon = " ",
        max_name_length = 14,
        max_prefix_length = 13,
        tab_size = 18,
        enforce_regular_tabs = true,
        show_buffer_close_icons = true,
        separator_style = "slant",
    },
    highlights = {
        background = {
            guifg = comment_fg,
            guibg = "#1e222a"
        },
        fill = {
            guifg = comment_fg,
            guibg = "#1e222a"
        },
        buffer_selected = {
            guifg = normal_fg,
            guibg = "#282c34",
            gui = "bold"
        },
        buffer_visible = {
            guifg = "#3e4451",
            guibg = "#1e222a"
        },
        separator_visible = {
            guifg = "#1e222a",
            guibg = "#1e222a"
        },
        separator_selected = {
            guifg = "#1e222a",
            guibg = "#1e222a"
        },
        separator = {
            guifg = "#1e222a",
            guibg = "#1e222a"
        },
        indicator_selected = {
            guifg = "#1e222a",
            guibg = "#1e222a"
        },
        modified_selected = {
            guifg = string_fg,
            guibg = "#353b45"
        }
    }
}

local opt = {silent = true}

--command that adds new buffer and moves to it
vim.api.nvim_command "com -nargs=? -complete=file_in_path New badd <args> | blast"
vim.api.nvim_set_keymap("n", "<S-b>", ":New ", opt)

--removing a buffer
vim.api.nvim_set_keymap("n", "<C-w>", [[<Cmd>bdelete<CR>]], opt)

-- tabnew and tabprev
vim.api.nvim_set_keymap("n", "<Tab>", [[<Cmd>BufferLineCycleNext<CR>]], opt)
vim.api.nvim_set_keymap("n", "<S-Tab>", [[<Cmd>BufferLineCyclePrev<CR>]], opt)

