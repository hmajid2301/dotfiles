{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nixicle; let
  cfg = config.nixicle.user;
in {
  options.nixicle.user = {
    enable = mkOpt types.bool false "Whether to configure the user account.";
    home = mkOpt (types.nullOr types.str) "/home/${cfg.name}" "The user's home directory.";
    name = mkOpt (types.nullOr types.str) config.snowfallorg.user.name "The user account.";

    settings = {
      default = {
        shell = mkOption {
          type = types.nullOr (types.enum ["fish" "zsh" "nushell"]);
          description = "The default shell to use";
          default = "fish";
        };

        terminal = mkOption {
          type = types.nullOr (types.enum ["alacritty" "foot" "wezterm"]);
          description = "The default terminal to use";
          default = "wezterm";
        };

        browser = mkOption {
          type = types.nullOr (types.enum ["firefox"]);
          description = "The default browser to use";
          default = "firefox";
        };

        editor = mkOption {
          type = types.nullOr (types.enum ["nvim"]);
          description = "The default editor to use";
          default = "nvim";
        };
      };

      wallpaper = mkOption {
        type = types.str;
        default = "";
        description = ''
          Wallpaper path
        '';
      };

      fonts = {
        regular = mkOption {
          type = types.str;
          description = "The font for regular text";
          default = "Fira Sans";
        };

        monospace = mkOption {
          type = types.str;
          description = "The font for monospace text";
          default = "MonoLisa Nerd Font";
        };
      };

      host = mkOption {
        type = types.str;
        default = "";
        description = ''
          Name of the host
        '';
      };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      assertions = [
        {
          assertion = cfg.name != null;
          message = "khanelinix.user.name must be set";
        }
      ];

      home = {
        homeDirectory = mkDefault cfg.home;
        username = mkDefault cfg.name;
      };
    }
  ]);
}
