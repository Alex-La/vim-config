local Util = require("alex-la.util")

return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        version = false, -- telescope did only one release, so use HEAD for now
        dependencies = {
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                enabled = vim.fn.executable("make") == 1,
                config = function()
                    Util.on_load("telescope.nvim", function ()
                        require("telescope").load_extension("fzf")
                    end)
                end,
            },
            {
                "nvim-telescope/telescope-file-browser.nvim",
                config = function ()
                    Util.on_load("telescope.nvim", function ()
                        require("telescope").load_extension("file_browser")
                    end)
                end,
            },
        },
        keys = {
            --find
            -- { "<leader>fc", Util.telescope.config_files(), desc = "Find Config File" },
        },
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            plugins = { spelling = true },
            defaults = {
                mode = { "n", "v" },
                -- ["g"] = { name = "+goto" },
                -- ["gs"] = { name = "+surround" },
                -- ["]"] = { name = "+next" },
                -- ["["] = { name = "+prev" },
                -- ["<leader><tab>"] = { name = "+tabs" },
                -- ["<leader>b"] = { name = "+buffer" },
                -- ["<leader>c"] = { name = "+code" },
                -- ["<leader>f"] = { name = "+file/find" },
                -- ["<leader>g"] = { name = "+git" },
                -- ["<leader>gh"] = { name = "+hunks" },
                -- ["<leader>q"] = { name = "+quit/session" },
                -- ["<leader>s"] = { name = "+search" },
                -- ["<leader>u"] = { name = "+ui" },
                -- ["<leader>w"] = { name = "+windows" },
                -- ["<leader>x"] = { name = "+diagnostics/quickfix" },
            },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            wk.register(opts.defaults)
        end,
    },
}