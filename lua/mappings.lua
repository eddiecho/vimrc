-- General key mappings

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- default Leader key
map("n", "]", "<Leader>")

-- Move vertically by visual line
map("", "j", "gj")
map("", "k", "gk")
map("", "<Down>", "gj")
map("", "<Up>", "gk")

-- Center search results
map("n", "n", "nzz")
map("n", "N", "Nzz")

-- Clear last search with Enter
map("n", "<CR>", ":noh<CR><CR>")

-- Because I'm a bad typist
map("c", "Wq", "wq")
map("c", "WQ", "wq")
map("c", "Qa", "qa")
map("c", "Wqa", "wqa")
map("c", "WQa", "wqa")
map("c", "Wa", "wa")
map("c", "WA", "wa")
map("c", "qw", "wq")
map("c", "qwa", "wqa")
map("c", "Qw", "wq")
map("c", "Qwa", "wqa")

-- Esc map
map("i", "kj", "<Esc>")

-- Split navigation
map("n", "H", "<C-w>h")
map("n", "L", "<C-w>l")
map("n", "K", "<C-w>k")
map("n", "J", "<C-w>j")
