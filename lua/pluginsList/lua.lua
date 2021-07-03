local execute = vim.api.nvim_command
local fn = vim.fn

local packer_ok, packer = pcall(require, "packer")
if not packer_ok then
  return
end

-- using { } when using a different branch of the plugin or loading the plugin with certain commands
return require("packer").startup(
    function()
        use {"wbthomason/packer.nvim", opt = true}

        -- Shows indentation
        use {"lukas-reineke/indent-blankline.nvim", branch = "lua"}
        -- Theme helper
        use "norcalli/nvim-base16.lua"
        use "nekonako/xresources-nvim"
        use "sainnhe/sonokai"
        -- File icons
        use "kyazdani42/nvim-web-devicons"
        use "ryanoasis/vim-devicons"
        -- File explorer, go back to ChadTree?
        use "kyazdani42/nvim-tree.lua"
        -- Show changes in the gutter
        use "lewis6991/gitsigns.nvim"
        -- Tab/buffers on the top
        use "akinsho/nvim-bufferline.lua"
        -- Statusline replacement
        use "glepnir/galaxyline.nvim"
        -- It's in the name
        use "907th/vim-auto-save"
        -- Syntax highlighting
        use "nvim-treesitter/nvim-treesitter"
        -- Highlight hex colors
        use "norcalli/nvim-colorizer.lua"
        -- Code formatting
        use "sbdchd/neoformat"
        -- Language server
        use "neovim/nvim-lspconfig"
        use "onsails/lspkind-nvim"
        use "ray-x/lsp_signature.nvim"
        -- Auto completion
        use "hrsh7th/nvim-compe"
        -- Auto pair some stuff
        use "windwp/nvim-autopairs"
        use "alvan/vim-closetag"
        -- Profile startup time for bottlenecks
        use "tweekmonster/startuptime.vim"
        -- Fuzzy finder
        use "nvim-telescope/telescope.nvim"
        use "nvim-telescope/telescope-media-files.nvim"
        -- Popup windows
        use "nvim-lua/popup.nvim"
        -- Used by other plugins as helper functions
        use "nvim-lua/plenary.nvim"
        -- Highlight trailing whitespace
        use "ntpeters/vim-better-whitespace"
        -- Debugger
        use "puremourning/vimspector"
        -- Live preview for search and replace
        use "markonm/traces.vim"
        -- Include snake_case and camelCase word skips
        use "chaoren/vim-wordmotion"
        -- Highlight merge conflicts
        use "rhysd/conflict-marker.vim"
        -- Show buffer contents
        use "junegunn/vim-peekaboo"
        -- Highlight yanks
        use "machakann/vim-highlightedyank"
    end
)
