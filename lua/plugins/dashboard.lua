return {
    "folke/snacks.nvim",
    opts = {
        dashboard = {
            preset = {
                keys = {
                    { icon = "\u{ea83} ",  key = "p", desc = "All Projects",    action = "<leader>fp" },
                    { icon = "\u{f1654} ", key = "f", desc = "Find File",       action = ":lua Snacks.dashboard.pick('files')" },
                    { icon = "\u{ea7f} ",  key = "n", desc = "New File",        action = ":ene | startinsert" },
                    { icon = "\u{f002} ",  key = "g", desc = "Find Text",       action = ":lua Snacks.dashboard.pick('live_grep')" },
                    { icon = "\u{f1da} ",  key = "r", desc = "Recent Files",    action = ":lua Snacks.dashboard.pick('oldfiles')" },
                    { icon = "\u{f013} ",  key = "c", desc = "Config",          action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                    { icon = "\u{f110d} ", key = "s", desc = "Restore Session", section = "session" },
                    { icon = "\u{f487} ",  key = "l", desc = "Lazy",            action = ":Lazy",                                                                enabled = package.loaded.lazy ~= nil },
                    { icon = "\u{f0431} ", key = "x", desc = "Lazy Extras",     action = ":LazyExtras",                                                          enabled = package.loaded.lazy ~= nil },
                    { icon = "\u{f011} ",  key = "q", desc = "Quit",            action = ":qa" },
                },
            },
        },
    },
}
