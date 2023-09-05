{ lib
, config
, pkgs
, ...
}:
let
  modifier = "Mod4";
in
{
  imports = [
    ./wayland
  ];

  # TODO: do I need this? Or is pkgs enough
  home.packages = with pkgs; [
    autotiling
    flashfocus
  ];

  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;
    config = {
      modifier = modifier;
      # TODO: move this to foot config or let it get set by home.nix
      terminal = "${pkgs.foot}/bin/foot";
      menu = "wofi --show drun";

      input."type:keyboard" = {
        xkb_layout = "gb";
        xkb_options = "ctrl:escape";
      };

      colors = {
        focused = {
          background = "#${config.colorscheme.colors.base07}";
          border = "#${config.colorscheme.colors.base07}";
          childBorder = "#${config.colorscheme.colors.base07}";
          indicator = "#${config.colorscheme.colors.base07}";
          text = "#ffffff";
        };
        unfocused = {
          background = "#${config.colorscheme.colors.base02}";
          border = "#${config.colorscheme.colors.base02}";
          childBorder = "#${config.colorscheme.colors.base02}";
          indicator = "#${config.colorscheme.colors.base02}";
          text = "#ffffff";
        };
      };

      bars = [
        {
          position = "top";
          command = "${pkgs.waybar}/bin/waybar";
        }
      ];

      gaps = {
        inner = 3;
        outer = 5;
      };

      focus = {
        followMouse = true;
      };

      startup = [
        # TODO: try swaync
        { command = "${pkgs.mako}/bin/mako"; }
        { command = "${pkgs.kanshi}/bin/kanshi"; }
        { command = "${pkgs.gammastep}/bin/gammastep-indicator"; }
        { command = "${pkgs.swaybg}/bin/swaybg -i ${config.wallpaper} --mode fill"; }
        { command = "sway-audio-idle-inhibit -w"; }
        { command = "${pkgs.flashfocus}/bin/flashfocus"; }
        { command = "${pkgs.autotiling}/bin/autotiling"; }
      ];

      keybindings = lib.mkOptionDefault {
        # TODO: do i need this with terminal
        "${modifier}+Return" = "exec ${pkgs.foot}/bin/foot";
        "${modifier}+b" = "exec ${config.home.sessionVariables.BROWSER}";
        "${modifier}+a" = "exec ${pkgs.wofi}/bin/wofi --show drun";
        "${modifier}+q" = "kill";
        "${modifier}+slash" = "workspace back_and_forth";
        "${modifier}+bracketright" = "workspace next";
        "${modifier}+bracketleft" = "workspace prev";
        XF86Launch5 = "swaylock -S";
        XF86Launch4 = "swaylock -S";
        "${modifier}+backspace" = "swaylock -S";

        # Print Screen
        Print = "grimblast --notify copysave area";
        "Shift+Print" = "grimblast --notify copysave active";
        "Control+Print" = "grimblast --notify copysave screen";
        "${modifier}+Print" = "grimblast --notify copy window";
        "ALT+Print" = "grimblast --notify copy area";
        "${modifier}+braceright" = "grimblast --notify --cursor copysave area ~/Pictures/$(date \"+%Y-%m-%d\" T \"%H:%M:%S_no_watermark\").png";
        "${modifier}+braceleft" = "grimblast --notify --cursor copy area";

        # Special Keys
        XF86MonBrightnessUp = "~/dotfiles/home-manager/desktops/wayland/scripts/brightness.sh --inc";
        XF86MonBrightnessDown = "~/dotfiles/home-manager/desktops/wayland/scripts/brightness.sh --dec";
        XF86AudioRaiseVolume = "~/dotfiles/home-manager/desktops/wayland/scripts/volume.sh --inc";
        XF86AudioLowerVolume = "~/dotfiles/home-manager/desktops/wayland/scripts/volume.sh --dec";
        XF86AudioMute = "~/dotfiles/home-manager/desktops/wayland/scripts/volume.sh --toggle";
        XF86AudioMicMute = "~/dotfiles/home-manager/desktops/wayland/scripts/volume.sh --toggle-mic";
        XF86AudioNext = "playerctl next";
        XF86AudioPrev = "playerctl previous";
        XF86AudioPlay = "playerctl play-pause";
        XF86AudioStop = "playerctl stop";
        "ALT+XF86AudioNext" = "playerctld shift";
        "ALT+XF86AudioPrev" = "playerctld unshift";
        "ALT+XF86AudioPlay" = "systemctl --user restart playerctld";
      };
    };

    extraConfig = ''
      corner_radius 5
    '';
  };
}