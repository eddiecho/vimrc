local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= "o" then
        scopes["o"][key] = value
    end
end

-- Buffers become hidden when abandoned
opt("o", "hidden", true)
-- Ignore case on search
opt("o", "ignorecase", true)
-- Better splits
opt("o", "splitbelow", true)
opt("o", "splitright", true)
-- Line numbers
opt("w", "number", true)
opt("o", "numberwidth", 2)
-- Highlight current line
opt("w", "cul", true)
-- Allow mouse
opt("o", "mouse", "a")
-- Signs next to line numbers
opt("w", "signcolumn", "yes")
-- Height of status line
opt("o", "cmdheight", 1)
-- Update delay time
opt("o", "updatetime", 250)
-- Allow copy paste
opt("o", "clipboard", "unnamedplus")
-- Tabs are just spaces
opt("b", "expandtab", true)
opt("b", "shiftwidth", 2)
-- Colors
opt("o", "termguicolors", true)
opt("o", "background", "dark")

