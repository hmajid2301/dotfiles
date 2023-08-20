{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [persistence-nvim];
    extraConfigLua =
      # lua
      ''
        require("persistence").setup({
          options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" },
          dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"), -- directory where session files are saved
          pre_save = nil, -- a function to call before saving the session
        })
      '';

    plugins.alpha = {
      enable = true;
      layout = [
        {
          type = "padding";
          val = 2;
        }
        {
          opts = {
            hl = "AlphaHeader";
            position = "center";
          };
          type = "text";
          val = [
            "  ███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗  "
            "  ████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║  "
            "  ██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║  "
            "  ██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║  "
            "  ██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║  "
            "  ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝  "
          ];
        }
        {
          type = "padding";
          val = 2;
        }
        {
          opts = {
            spacing = 1;
            hl = "AlphaButtons";
            position = "center";
          };
          type = "group";
          val = [
            {
              command = "<CMD>:Telescope find_files follow=true no_ignore=true hidden=true <CR>";
              desc = "  Find file";
              shortcut = "f";
            }
            {
              command = "<CMD>ene <CR>";
              desc = "  New file";
              shortcut = "e";
            }
            {
              command = "<CMD>:e $MYVIMRC <CR>";
              desc = "  Config";
              shortcut = "c";
            }
            {
              command = "[[:lua require('persistence').load() <cr>]]";
              desc = " Restore Session";
              shortcut = "s";
            }
            {
              command = ":qa<CR>";
              desc = "  Quit Neovim";
              shortcut = "q";
            }
          ];
        }
        {
          type = "padding";
          val = 2;
        }
        {
          opts = {
            hl = "AlphaFooter";
            position = "center";
          };
          type = "text";
          val = ''
            If debugging is the process of removing software bugs, then programming must be the process of putting them in. - Dijsktra;
          '';
        }
      ];
    };
  };
}