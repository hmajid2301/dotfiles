{
  programs.nixvim = {
    plugins.lualine = {
      enable = true;
      settings = {
        options = {
          globalstatus = true;
          icons_enabled = true;
          theme = "catppuccin";
          section_separators = {
            right = "";
            left = "▊ ";
          };
          component_separators = {
            left = "";
            right = "";
          };
        };

        sections = {
          lualine_a = [
            {
              __unkeyed-1 = "mode";
              icon = " ";
              color = {
                gui = "bold";
              };
            }
          ];
          lualine_b = [
            {
              __unkeyed-1 = "filetype";
              icon_only = true;
              colored = false;
              icon = {
                color = {
                  fg = "#FFF";
                };
              };
              padding = {
                left = 1;
                right = 0;
              };
            }
            {
              __unkeyed-1 = "filename";
              color = {
                fg = "#FFF";
              };
            }
          ];
          lualine_c = [
            {
              __unkeyed-1 = "branch";
              padding = {
                left = 2;
                right = 0;
              };
              icon = "";
              colored = false;
              color = {
                gui = "bold";
                fg = "#605f6f";
              };
            }
            {
              __unkeyed-1 = "diff";
              colored = false;
              color = {
                gui = "bold";
                fg = "#605f6f";
              };
              symbols = {
                added = " ";
                modified = " ";
                removed = " ";
              };
            }
          ];
          lualine_x = [
            {
              __unkeyed-1 = "diagnostics";
              color = {
                fg = "#605f6f";
                gui = "bold";
              };
              diagnostics_color = {
                color_error = {fg = "#F38BA8";};
                color_warn = {fg = "#FAE3B0";};
              };
              symbols = {
                error = " ";
                warn = " ";
              };
            }
            {
              name.__raw =
                # lua
                ''
                  function()
                  	 return (vim.t.maximized and " ") or ""
                  end
                '';
              color = {
                fg = "#2d2c3c";
                bg = "#CBA6F7";
                gui = "bold";
              };
              separator = {
                left = "";
              };
            }
          ];
          lualine_y = [
            # TODO: fix this hack for showing icon with colors
            {
              name.__raw =
                # lua
                ''
                  function()
                      return "  "
                  end
                '';

              padding = {
                left = 0;
                right = 0;
              };
              separator = {
                left = "";
              };
              color = {
                fg = "#2d2c3c";
                bg = "#8bc2f0";
              };
            }
            {
              name.__raw =
                # lua
                ''
                  function()
                  		local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                  		local clients = vim.lsp.get_active_clients()
                  		if next(clients) == nil then
                  				return "None"
                  		end

                  		local msg = ""
                  		for _, client in ipairs(clients) do
                  				local filetypes = client.config.filetypes
                  				if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 and client.name ~= "null-ls" then
                  						msg = msg .. client.name .. " "
                  				end
                  		end

                  		if msg then
                  			return msg
                  		else
                  			return "None"
                  		end

                  	end
                '';
              color = {
                fg = "#D9E0EE";
                bg = "#2f2e3e";
                gui = "bold";
              };
            }
            {
              name.__raw =
                # lua
                ''
                  function()
                      return " "
                  end
                '';

              padding = {
                left = 0;
                right = 0;
              };
              separator = {
                left = "";
              };
              color = {
                fg = "#2d2c3c";
                bg = "#F38BA8";
                gui = "bold";
              };
            }
            {
              name = "location";
              extraConfig = {
                color = {
                  fg = "#D9E0EE";
                  bg = "#2f2e3e";
                };
              };
            }
          ];
          lualine_z = [
            {
              __unkeyed-1 = "progress";
              icon = {
                __unkeyed-1 = "";
              };
              padding = {
                left = 0;
                right = 0;
              };
              separator = {
                left = "";
              };
              color = {
                bg = "#2d2c3c";
                fg = "#ABE9B3";
              };
            }
          ];
        };
      };
    };
  };
}
