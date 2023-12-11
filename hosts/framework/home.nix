{ inputs
, pkgs
, lib
, config
, ...
}: {
  imports = [
    ../../home-manager

    ../../home-manager/games
  ];

  config = {
    modules = {
      browsers = {
        firefox.enable = true;
      };

      editors = {
        nvim.enable = true;
      };

      multiplexers = {
        tmux.enable = true;
        zellij.enable = true;
      };

      shells = {
        fish.enable = true;
      };

      wms = {
        hyprland.enable = true;
      };

      terminals = {
        foot.enable = true;
        wezterm.enable = true;
      };
    };

    my.settings = {
      wallpaper = "~/Pictures/wallpapers/nixppuccin.png";
      host = "framework";
      default = {
        shell = "${pkgs.fish}/bin/fish";
        terminal = "${pkgs.foot}/bin/foot";
        browser = "firefox";
        editor = "nvim";
      };
      fonts.monospace = "FiraCode Nerd Font Mono";
    };

    colorscheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

    home = {
      username = lib.mkDefault "haseeb";
      homeDirectory = lib.mkDefault "/home/${config.home.username}";
      stateVersion = lib.mkDefault "23.11";
    };
  };
}
