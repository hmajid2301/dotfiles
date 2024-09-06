{pkgs, ...}: {
  programs.nixvim = {
    keymaps = [
      {
        action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
        key = "<leader>ca";
        mode = ["n" "v"];
        options = {
          desc = "Code Actions";
        };
      }
      {
        action = "<cmd>LspRestart<CR>";
        key = "<leader>lR";
        mode = ["n"];
        options = {
          desc = "Restart LSP";
        };
      }
      {
        action = "<cmd>Telescope lsp_references<CR>";
        key = "<leader>gr";
        mode = ["n"];
        options = {
          desc = "LSP References";
        };
      }
    ];

    plugins = {
      lsp = {
        enable = true;

        keymaps = {
          diagnostic = {
            "]d" = "goto_next";
            "[d" = "goto_prev";
          };
          lspBuf = {
            K = "hover";
            gD = "declaration";
            # gr = "references";
            gd = "definition";
            gi = "implementation";
            gt = "type_definition";
            "<leader>cr" = {
              action = "rename";
              desc = "Rename";
            };
          };
        };
      };

      conform-nvim = {
        enable = true;
        settings = {
          format_on_save = {
            lsp_fallback = true;
            timeout_ms = 500;
          };
        };
      };

      lint = {
        enable = true;
      };
    };

    extraConfigLua =
      # lua
      ''
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        	border = "rounded",
        })

        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        	callback = function()
        		require("lint").try_lint()
        	end,
        })
      '';
  };
}

Okay ladies and gentlefish,


The time has arrived, what you've all been waiting for. Access to my big beautiful homelab.
Use this invite to create an account: https://authentik.haseebmajid.dev/if/flow/enrollment-invitation/?itoken=3bfc1357-a499-4cc2-bc83-dda31a1f5d75

Then sign up for: https://tandoor-recipes.haseebmajid.dev/, a way to manage recipes, meal planning and maybe a shopping list.

You can also access: https://paperless.haseebmajid.dev/accounts/login/?next=/
A place to digitally store important documents, which can be auto-tagged etc and provides lot of cool features
to make it easier to search.

When signin up for both make sure to click on "Sign in with Authentik"

I will include more apps later. Like a media server, where you can request shows and automagically watch them.
