return {
    --------------------------------------------------------------------------
    -- {{{ undotree
    {
        "mbbill/undotree",
        lazy = true,
        keys = {
            { "u", mode = "n" }
        },
        config = function()
            require("which-key").register({
                ["<leader>u"] = {
                    ":UndotreeToggle<CR>",
                    "Toggle undotree",
                    mode = "n",
                    noremap = true,
                },
            })
        end
    },

    -- }}}

    --------------------------------------------------------------------------
    -- {{{ vim-sleuth
    {
        "tpope/vim-sleuth",
        lazy = false,
    },
    -- }}}

    --------------------------------------------------------------------------
    -- {{{ glow.nvim
    {
        "ellisonleao/glow.nvim",
        cmd = "Glow",
        ft = "markdown",
        config = function()
            require('glow').setup({
                {
                    glow_path = "",                -- will be filled automatically with your glow bin in $PATH, if any
                    install_path = "~/.local/bin", -- default path for installing glow binary
                    border = "shadow",             -- floating window border config
                    style = "dark|light",          -- filled automatically with your current editor background, you can override using glow json style
                    pager = false,
                    width = 80,
                    height = 100,
                    width_ratio = 0.7, -- maximum width of the Glow window compared to the nvim window size (overrides `width`)
                    height_ratio = 0.7,
                }
            })
        end,
    },
    -- }}}

    --------------------------------------------------------------------------
    -- {{{ which-key
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            plugins = {
                marks = true,     -- shows a list of your marks on ' and `
                registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
                -- the presets plugin, adds help for a bunch of default keybindings in Neovim
                -- No actual key bindings are created
                spelling = {
                    enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
                    suggestions = 20, -- how many suggestions should be shown in the list?
                },
                presets = {
                    operators = true,    -- adds help for operators like d, y, ...
                    motions = true,      -- adds help for motions
                    text_objects = true, -- help for text objects triggered after entering an operator
                    windows = true,      -- default bindings on <c-w>
                    nav = true,          -- misc bindings to work with windows
                    z = true,            -- bindings for folds, spelling and others prefixed with z
                    g = true,            -- bindings for prefixed with g
                },
            },
            -- add operators that will trigger motion and text object completion
            -- to enable all native operators, set the preset / operators plugin above
            operators = { gc = "Comments" },
            key_labels = {
                -- override the label used to display some keys. It doesn't effect WK in any other way.
                -- For example:
                -- ["<space>"] = "SPC",
                -- ["<cr>"] = "RET",
                -- ["<tab>"] = "TAB",
            },
            motions = {
                count = true,
            },
            icons = {
                breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
                separator = "➜", -- symbol used between a key and it's label
                group = "+", -- symbol prepended to a group
            },
            popup_mappings = {
                scroll_down = "<c-d>", -- binding to scroll down inside the popup
                scroll_up = "<c-u>",   -- binding to scroll up inside the popup
            },
            window = {
                border = "single",        -- none, single, double, shadow
                position = "bottom",      -- bottom, top
                margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
                padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
                winblend = 0,             -- value between 0-100 0 for fully opaque and 100 for fully transparent
                zindex = 1000,            -- positive value to position WhichKey above other floating windows.
            },
            layout = {
                height = { min = 4, max = 25 },                                               -- min and max height of the columns
                width = { min = 20, max = 50 },                                               -- min and max width of the columns
                spacing = 3,                                                                  -- spacing between columns
                align = "left",                                                               -- align columns left, center or right
            },
            ignore_missing = false,                                                           -- enable this to hide mappings for which you didn't specify a label
            hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "^:", "^ ", "^call ", "^lua " }, -- hide mapping boilerplate
            show_help = true,                                                                 -- show a help message in the command line for using WhichKey
            show_keys = true,                                                                 -- show the currently pressed key and its label as a message in the command line
            triggers = "auto",                                                                -- automatically setup triggers
            -- triggers = {"<leader>"} -- or specifiy a list manually
            -- list of triggers, where WhichKey should not wait for timeoutlen and show immediately
            triggers_nowait = {
                -- marks
                "`",
                "'",
                "g`",
                "g'",
                -- registers
                '"',
                "<c-r>",
                -- spelling
                "z=",
            },
            triggers_blacklist = {
                -- list of mode / prefixes that should never be hooked by WhichKey
                -- this is mostly relevant for keymaps that start with a native binding
                i = { "j", "k" },
                v = { "j", "k" },
            },
            -- disable the WhichKey popup for certain buf types and file types.
            -- Disabled by default for Telescope
            disable = {
                buftypes = {},
                filetypes = {},
            },
        },
    },
    -- }}}

    --------------------------------------------------------------------------
    -- {{{ bigfile.nvim
    {
        "LunarVim/bigfile.nvim",
        lazy = false,
        config = function()
            local toggle_big_file = {
                name = "toggle_big_file", -- name
                opts = {
                    defer = true,         -- set to true if `disable` should be called on `BufReadPost` and not `BufReadPre`
                },
                disable = function()      -- called to disable the feature
                    vim.g.opening_big_file = true
                    vim.b.opening_big_file = true
                end,
                enable = function() -- called to enable the feature
                    vim.g.opening_big_file = false
                    vim.b.opening_big_file = false
                end,
            }

            local nvim_cmp = {
                name = "nvim_cmp",   -- name
                opts = {
                    defer = true,    -- set to true if `disable` should be called on `BufReadPost` and not `BufReadPre`
                },
                disable = function() -- called to disable the feature
                    vim.g.enable_nvim_cmp = false
                end,
                enable = function() -- called to enable the feature
                    vim.g.enable_nvim_cmp = true
                end,
            }

            local codeium = {
                name = "codeium",    -- name
                opts = {
                    defer = false,   -- set to true if `disable` should be called on `BufReadPost` and not `BufReadPre`
                },
                disable = function() -- called to disable the feature
                    vim.cmd([[CodeiumDisable]])
                end,
                enable = function() -- called to enable the feature
                    vim.cmd([[CodeiumEnable]])
                end,
            }

            require("bigfile").setup {
                filesize = 2,      -- size of the file in MiB, the plugin round file sizes to the closest MiB
                pattern = { "*" }, -- autocmd pattern or function see <### Overriding the detection of big files>
                features = {       -- features to disable
                    "indent_blankline",
                    "illuminate",
                    "lsp",
                    "treesitter",
                    "syntax",
                    "matchparen",
                    "vimopts",
                    "filetype",
                    nvim_cmp,
                    codeium,
                    toggle_big_file
                },
            }
        end
    },
    -- }}}
    --------------------------------------------------------------------------
    -- {{{ gitsigns
    { -- Adds git related signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
        },
        config = function()
            require("gitsigns").setup()
            vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
            vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", {})
            vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", {})
        end
    },
    -- }}}
    --------------------------------------------------------------------------
    -- {{{ image_preview
    {
        "vhyrro/luarocks.nvim",
        priority = 1001, -- this plugin needs to run before anything else
        opts = {
            rocks = { "magick" },
        },
    },
    {
        "3rd/image.nvim",
        dependencies = { "luarocks.nvim" },
        config = function()
            -- ...
        end
    } -- }}}

}
