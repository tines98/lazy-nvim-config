local M = {}

function M.getProject()
  local project_file_path = vim.fn.findfile(".project.lua", ".;")
  if project_file_path == "" then
    return nil
  end
  local project_file = dofile(project_file_path)

  return project_file
end

M.org_mapper = {
  ["personal"] = "\u{f415} Personal",
  ["bekk"] = "\u{f491} Bekk",
  [".config"] = "\u{e615} Config",
  ["etc"] = "\u{f313} NixOS",
  default = "\u{f128} UNKNOWN",
}

M.org_colors = {
  ["personal"] = "OrgPersonal",
  ["bekk"] = "OrgBekk",
  [".config"] = "OrgConfig",
  ["etc"] = "OrgNixOS",
  default = "OrgDefault",
}

return M
