local conditions = require('heirline.conditions')
local colors = require('nvimpire').colors
local helpers = require('user.plugins.heirline.helpers')

local lsp_map = {
  gopls = "go",
  lua_ls = "lua",
  json_ls = "json",
  tsserver = "typescript",
  tailwindcss = "",
  golangci_lint = "",
}

local LspActive = {
  condition = conditions.lsp_attached,
  {
    hl = function(self)
      return {
        fg = colors.bg_lighter,
        bg = self.show_diagnostics and colors.bg_light or colors.none
      }
    end,
    provider = helpers.LeftBubbleChar,
  },
  {
    provider = function()
      local names = {}

      local current_buff = vim.api.nvim_get_current_buf()
      for _, client in pairs(vim.lsp.get_active_clients({ bufnr = current_buff })) do
        local show_name = client.name
        if client.name ~= 'null-ls' and lsp_map[client.name] ~= "" then
          show_name = lsp_map[client.name]
        end
        table.insert(names, show_name)
      end

      return "ﯶ " .. table.concat(names, ", ") .. " "
    end,
    hl = {
      fg = colors.purple,
      bg = colors.bg_lighter,
      bold = true
    },
  },
}

return LspActive
