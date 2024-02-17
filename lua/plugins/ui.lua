return {
    
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
        vim.cmd([[colorscheme catppuccin]])
        end,
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            presets = {
                bottom_search = true,
                command_palette = true,
            },
        },
    },
}