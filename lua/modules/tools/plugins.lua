local tools = {}
local conf = require("modules.tools.config")

tools["RishabhRD/popfix"] = {opt = false}
tools["nvim-lua/plenary.nvim"] = {opt = false}
tools["nvim-telescope/telescope.nvim"] = {
    opt = true,
    module = "telescope",
    cmd = "Telescope",
    config = conf.telescope,
    requires = {
        {"nvim-lua/plenary.nvim", opt = false},
        {"nvim-lua/popup.nvim", opt = true},
        {"rmagatti/auto-session", opt = true}
    }
}
tools["nvim-telescope/telescope-fzf-native.nvim"] = {
    opt = true,
    run = "make",
    after = "telescope.nvim"
}
tools["nvim-telescope/telescope-project.nvim"] = {
    -- disable = true,
    opt = true,
    after = "telescope.nvim"
}
tools["nvim-telescope/telescope-frecency.nvim"] = {
    opt = true,
    after = "telescope.nvim",
    requires = {{"tami5/sqlite.lua", opt = true}}
}
tools["jvgrootveld/telescope-zoxide"] = {opt = true, after = "telescope.nvim"}
tools["ahmedkhalf/project.nvim"] = {
    opt = true,
    after = "telescope.nvim",
    config = conf.project
}
tools["rmagatti/auto-session"] = {
    opt = true,
    cmd = {"SaveSession", "RestoreSession", "DeleteSession"},
    config = conf.auto_session
}
tools["rmagatti/session-lens"] = {
    disable = true,
    opt = true,
    after = "telescope.nvim",
    requires = {'rmagatti/auto-session', 'nvim-telescope/telescope.nvim'},
    config = function()
        require('session-lens').setup({})
    end
}
tools["Shatur/neovim-session-manager"] = {
    opt = true,
    cmd = { "SessionManager" },
    config = conf.session_manager
}
tools["thinca/vim-quickrun"] = {opt = true, cmd = {"QuickRun", "Q"}}
tools["michaelb/sniprun"] = {
    opt = true,
    run = "bash ./install.sh",
    cmd = {"SnipRun", "'<,'>SnipRun"}
}
tools["folke/which-key.nvim"] = {
    opt = false,
    -- keys = "<Space>",
    config = function() require("which-key").setup {} end
}
tools["folke/trouble.nvim"] = {
    opt = true,
    cmd = {"Trouble", "TroubleToggle", "TroubleRefresh"},
    config = conf.trouble
}
tools["dstein64/vim-startuptime"] = {opt = true, cmd = "StartupTime"}
tools["gelguy/wilder.nvim"] = {
    event = "CmdlineEnter",
    config = conf.wilder,
    requires = {{"romgrk/fzy-lua-native", after = "wilder.nvim"}}
}

return tools
