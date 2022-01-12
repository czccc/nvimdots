local config = {}

function config.telescope()
    if not packer_plugins["sqlite.lua"].loaded then
        vim.cmd [[packadd sqlite.lua]]
    end

    if not packer_plugins["telescope-fzf-native.nvim"].loaded then
        vim.cmd [[packadd telescope-fzf-native.nvim]]
    end

    if not packer_plugins["telescope-project.nvim"].loaded then
        vim.cmd [[packadd telescope-project.nvim]]
    end

    if not packer_plugins["telescope-frecency.nvim"].loaded then
        vim.cmd [[packadd telescope-frecency.nvim]]
    end

    if not packer_plugins["telescope-zoxide"].loaded then
        vim.cmd [[packadd telescope-zoxide]]
    end

    if not packer_plugins["project.nvim"].loaded then
        vim.cmd [[packadd project.nvim]]
    end

    if not packer_plugins["session-lens"].loaded then
        vim.cmd [[packadd session-lens]]
    end

    require("telescope").setup {
        defaults = {
            prompt_prefix = "🔭 ",
            selection_caret = " ",
            layout_config = {
                horizontal = {prompt_position = "bottom", results_width = 0.6},
                vertical = {mirror = false}
            },
            file_previewer = require("telescope.previewers").vim_buffer_cat.new,
            grep_previewer = require("telescope.previewers").vim_buffer_vimgrep
                .new,
            qflist_previewer = require("telescope.previewers").vim_buffer_qflist
                .new,
            file_sorter = require("telescope.sorters").get_fuzzy_file,
            file_ignore_patterns = {},
            generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
            path_display = {"absolute"},
            winblend = 0,
            border = {},
            borderchars = {
                "─", "│", "─", "│", "╭", "╮", "╯", "╰"
            },
            color_devicons = true,
            use_less = true,
            set_env = {["COLORTERM"] = "truecolor"}
        },
        extensions = {
            fzf = {
                fuzzy = false, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case" -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            },
            frecency = {
                show_scores = true,
                show_unindexed = true,
                ignore_patterns = {"*.git/*", "*/tmp/*"}
            }
        }
    }

    require("telescope").load_extension("fzf")
    require("telescope").load_extension("project")
    require("telescope").load_extension("zoxide")
    require("telescope").load_extension("frecency")
    require('telescope').load_extension('projects')
    require("telescope").load_extension("session-lens")
end

function config.project()
    require("project_nvim").setup {
        -- Manual mode doesn't automatically change your root directory, so you have
        -- the option to manually do so using `:ProjectRoot` command.
        manual_mode = false,

        -- Methods of detecting the root directory. **"lsp"** uses the native neovim
        -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
        -- order matters: if one is not detected, the other is used as fallback. You
        -- can also delete or rearangne the detection methods.
        detection_methods = { "lsp", "pattern" },

        -- All the patterns used to detect root dir, when **"pattern"** is in
        -- detection_methods
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },

        -- Table of lsp clients to ignore by name
        -- eg: { "efm", ... }
        ignore_lsp = {},

        -- Don't calculate root dir on specific directories
        -- Ex: { "~/.cargo/*", ... }
        exclude_dirs = {},

        -- Show hidden files in telescope
        show_hidden = false,

        -- When set to false, you will get a message when project.nvim changes your
        -- directory.
        silent_chdir = true,

        -- Path where project.nvim will store the project history for use in
        -- telescope
        datapath = vim.fn.stdpath("data"),
    }
end

function config.auto_session()
    local opts = {
        log_level = "info",
        auto_session_enable_last_session = true,
        auto_session_root_dir = sessions_dir,
        auto_session_enabled = true,
        auto_save_enabled = true,
        auto_restore_enabled = true,
        auto_session_suppress_dirs = nil
    }

    require("auto-session").setup(opts)
end

function config.trouble()
    require("trouble").setup {
        position = "bottom", -- position of the list can be: bottom, top, left, right
        height = 10, -- height of the trouble list when position is top or bottom
        width = 50, -- width of the list when position is left or right
        icons = true, -- use devicons for filenames
        mode = "document_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
        fold_open = "", -- icon used for open folds
        fold_closed = "", -- icon used for closed folds
        action_keys = {
            -- key mappings for actions in the trouble list
            -- map to {} to remove a mapping, for example:
            -- close = {},
            close = "q", -- close the list
            cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
            refresh = "r", -- manually refresh
            jump = {"<cr>", "<tab>"}, -- jump to the diagnostic or open / close folds
            open_split = {"<c-x>"}, -- open buffer in new split
            open_vsplit = {"<c-v>"}, -- open buffer in new vsplit
            open_tab = {"<c-t>"}, -- open buffer in new tab
            jump_close = {"o"}, -- jump to the diagnostic and close the list
            toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
            toggle_preview = "P", -- toggle auto_preview
            hover = "K", -- opens a small popup with the full multiline message
            preview = "p", -- preview the diagnostic location
            close_folds = {"zM", "zm"}, -- close all folds
            open_folds = {"zR", "zr"}, -- open all folds
            toggle_fold = {"zA", "za"}, -- toggle fold of current file
            previous = "k", -- preview item
            next = "j" -- next item
        },
        indent_lines = true, -- add an indent guide below the fold icons
        auto_open = false, -- automatically open the list when you have diagnostics
        auto_close = false, -- automatically close the list when you have no diagnostics
        auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
        auto_fold = false, -- automatically fold a file trouble list at creation
        signs = {
            -- icons / text used for a diagnostic
            error = "",
            warning = "",
            hint = "",
            information = "",
            other = "﫠"
        },
        use_lsp_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
    }
end

function config.sniprun()
    require"sniprun".setup({
        selected_interpreters = {}, -- " use those instead of the default for the current filetype
        repl_enable = {}, -- " enable REPL-like behavior for the given interpreters
        repl_disable = {}, -- " disable REPL-like behavior for the given interpreters
        interpreter_options = {}, -- " intepreter-specific options, consult docs / :SnipInfo <name>
        -- " you can combo different display modes as desired
        display = {
            "Classic", -- "display results in the command-line  area
            "VirtualTextOk", -- "display ok results as virtual text (multiline is shortened)
            "VirtualTextErr", -- "display error results as virtual text
            -- "TempFloatingWindow",      -- "display results in a floating window
            "LongTempFloatingWindow" -- "same as above, but only long results. To use with VirtualText__
            -- "Terminal"                 -- "display results in a vertical split
        },
        -- " miscellaneous compatibility/adjustement settings
        inline_messages = 0, -- " inline_message (0/1) is a one-line way to display messages
        -- " to workaround sniprun not being able to display anything

        borders = "shadow" -- " display borders around floating windows
        -- " possible values are 'none', 'single', 'double', or 'shadow'
    })
end

function config.wilder()
    vim.cmd [[
call wilder#setup({'modes': [':', '/', '?']})
call wilder#set_option('use_python_remote_plugin', 0)

call wilder#set_option('pipeline', [wilder#branch(wilder#cmdline_pipeline({'use_python': 0,'fuzzy': 1, 'fuzzy_filter': wilder#lua_fzy_filter()}),wilder#vim_search_pipeline(), [wilder#check({_, x -> empty(x)}), wilder#history(), wilder#result({'draw': [{_, x -> ' ' . x}]})])])

call wilder#set_option('renderer', wilder#renderer_mux({':': wilder#popupmenu_renderer({'highlighter': wilder#lua_fzy_highlighter(), 'left': [wilder#popupmenu_devicons()], 'right': [' ', wilder#popupmenu_scrollbar()]}), '/': wilder#wildmenu_renderer({'highlighter': wilder#lua_fzy_highlighter()})}))
]]
end

return config
