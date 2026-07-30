return {
  "ahmedkhalf/project.nvim",
  lazy = false,
  dependencies = { "nvim-telescope/telescope.nvim", lazy = true },
  config = function()
    require("project_nvim").setup({
      manual_mode = false,
      detection_methods = { "pattern" },
      patterns = { ".git" },
      show_hidden = false,
      silent_chdir = true,
      datapath = vim.fn.stdpath("data"),
    })

    -- Organization Colors
    vim.api.nvim_set_hl(0, "OrgPersonal", { fg = "#a970c7" })
    vim.api.nvim_set_hl(0, "OrgBekk", { fg = "#C93D36" })
    vim.api.nvim_set_hl(0, "OrgAutopay", { fg = "#FF9E75" })
    vim.api.nvim_set_hl(0, "OrgNationaltheatret", { fg = "#C1D9BB" })
    vim.api.nvim_set_hl(0, "OrgConfig", { fg = "#54A23D" })
    vim.api.nvim_set_hl(0, "OrgDefault", { fg = "white" })

    -- Defer the telescope extension load until telescope is actually loaded
    vim.api.nvim_create_autocmd("User", {
      pattern = "TelescopeLoaded", -- or hook this off VeryLazy if you don't have that event
      once = true,
      callback = function()
        require("telescope").load_extension("projects")
      end,
    })
  end,
  keys = {
    {
      "<leader>fp",
      function()
        -- Manually populate the history file with all git repos
        local dev_dir = vim.fn.expand("~/dev")
        local history_file = vim.fn.stdpath("data") .. "/project_nvim/project_history"

        vim.fn.mkdir(vim.fn.stdpath("data") .. "/project_nvim", "p")

        local handle = io.popen(
          "find "
            .. dev_dir
            .. " -maxdepth 3 -type d -name '.git' 2>/dev/null;"
            .. "find ~/.config -maxdepth 3 -type d -name '.git' 2>/dev/null"
            .. "find /etc/nixos -type d 2>/dev/null"
        )
        local projects = {}

        if handle then
          for git_dir in handle:lines() do
            local project_dir = git_dir:gsub("/.git$", "")
            table.insert(projects, project_dir)
          end
          handle:close()
        end

        table.sort(projects, function(a, b)
          local parts_a = vim.split(a, "/")
          local parts_b = vim.split(b, "/")
          local org_a = parts_a[#parts_a - 1] or ""
          local org_b = parts_b[#parts_b - 1] or ""

          if org_a == org_b then
            return a < b
          end
          return org_a < org_b
        end)

        local file = io.open(history_file, "w")
        if file then
          for _, project in ipairs(projects) do
            file:write(project .. "\n")
          end
          file:close()
        end

        local pickers = require("telescope.pickers")
        local finders = require("telescope.finders")
        local conf = require("telescope.config").values
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")
        local entry_display = require("telescope.pickers.entry_display")

        local displayer = entry_display.create({
          separator = " ",
          items = {
            { width = 15 }, -- org name width
            { remaining = true }, -- repo name
          },
        })

        pickers
          .new({}, {
            prompt_title = "Projects (grouped by org)",
            finder = finders.new_table({
              results = projects,
              entry_maker = function(entry)
                local utils = require("config.utils")

                local parts = vim.split(entry, "/")
                local org = parts[#parts - 1] or "unknown"
                local repo = parts[#parts] or entry

                local hl_group = utils.org_colors[org] or utils.org_colors.default

                local org_display = utils.org_mapper[org] or utils.org_mapper.default

                return {
                  value = entry,
                  display = function(tbl)
                    return displayer({
                      { "" .. org_display .. ":", hl_group },
                      { repo, hl_group },
                    })
                  end,
                  ordinal = org .. " " .. repo,
                  path = entry,
                }
              end,
            }),
            sorter = conf.generic_sorter({}),
            attach_mappings = function(prompt_bufnr)
              actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                -- Change directory to the project folder
                vim.cmd("cd " .. selection.value)

                -- Open README if possible
                local readme = vim.fn.findfile("README.md")
                if readme ~= "" then
                  vim.cmd("edit " .. readme)
                end

                -- Open Snacks explorer
                Snacks.explorer.open()
              end)
              return true
            end,
          })
          :find()
      end,
      desc = "All Projects", -- This description shows in which-key and dashboard
    },
  },
}
