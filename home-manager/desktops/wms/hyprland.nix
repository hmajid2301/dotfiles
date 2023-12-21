{ inputs
, config
, lib
, pkgs
, ...
}:
with lib;
let
  laptop_lid_switch = pkgs.writeShellScriptBin "laptop_lid_switch" ''
    #!/usr/bin/env bash

    if grep open /proc/acpi/button/lid/LID0/state; then
    		hyprctl keyword monitor "eDP-1, 2256x1504@60, 0x0, 1"
    else
    		if [[ `hyprctl monitors | grep "Monitor" | wc -l` != 1 ]]; then
    				hyprctl keyword monitor "eDP-1, disable"
    		else
    				systemctl suspend
    		fi
    fi
  '';
  cfg = config.modules.wms.hyprland;
in
{
  options.modules.wms.hyprland = {
    enable = mkEnableOption "enable hyprland window manager";
  };

  config = mkIf cfg.enable {
    home.packages = [
      inputs.hypr-contrib.packages.${pkgs.system}.grimblast
      inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
      pkgs.satty
      pkgs.pyprland
    ];

    nix.settings = {
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };

    xdg.configFile."hypr/pyprland.json".text = ''
      {
      	"pyprland": {
      		"plugins": ["scratchpads"]
      	},
      	"scratchpads": {
      		"term": {
      			"command": "foot --title scratchpad",
      			"margin": 50,
      			"unfocus": "hide"
      		},
      		"yazi": {
      			"command": "foot --title scratchpad -m fish -c yazi",
      			"margin": 50
      		}
      	}
      }
    '';

    wayland.windowManager.hyprland = {
      enable = true;
      # TODO: move to https://github.com/spikespaz/hyprland-nix
      extraConfig = ''
         # ASCII Art from https://fsymbols.com/generators/carty/
         input {
        	kb_layout = gb
        	touchpad {
        		disable_while_typing=false
        	}
         }

         general {
        	gaps_in = 3
        	gaps_out = 5
        	border_size = 3
        	col.active_border=0xff${config.colorscheme.colors.base07}
        	col.inactive_border=0xff${config.colorscheme.colors.base02}
         }

         decoration {
        	rounding=5
         }

         misc {
        	vrr = 2
        	disable_hyprland_logo = 1;
        	disable_splash_rendering = 1;
         }

         $notifycmd = notify-send -h string:x-canonical-private-synchronous:hypr-cfg -u low
         env = QT_QPA_PLATFORM,wayland
         env = QT_QPA_PLATFORMTHEME,qt5ct

         # █▀ █░█ █▀█ █▀█ ▀█▀ █▀▀ █░█ ▀█▀ █▀
         # ▄█ █▀█ █▄█ █▀▄ ░█░ █▄▄ █▄█ ░█░ ▄█
         bind = SUPER, Return, exec, ${config.my.settings.default.terminal}
         bind = SUPER, b, exec, ${config.my.settings.default.browser}
         bind = SUPER, a, exec, ${pkgs.rofi}/bin/rofi -show drun -mode drun
         bind = SUPER, Tab, exec, ${pkgs.rofi}/bin/rofi -show window

         # █▀▀ ▀▄▀ █▀▀ █▀▀ █▀█ ▀█▀ █ █▀█ █▄░█ █▀
         # ██▄ █░█ █▄▄ ██▄ █▀▀ ░█░ █ █▄█ █░▀█ ▄█
         windowrule = fullscreen, title:^(Guild Wars 2)$
         windowrulev2 = idleinhibit focus, class:^(mpv)$
         windowrulev2 = idleinhibit fullscreen, class:^(firefox)$

         # ▄▀█ █░█ ▀█▀ █▀█   █▀ ▀█▀ ▄▀█ █▀█ ▀█▀
         # █▀█ █▄█ ░█░ █▄█   ▄█ ░█░ █▀█ █▀▄ ░█░
         exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
         exec-once = ${pkgs.swaynotificationcenter}/bin/swaync
         exec-once = ${pkgs.kanshi}/bin/kanshi &
         exec-once = ${pkgs.nur.repos."999eagle".swayaudioidleinhibit}/bin/sway-audio-idle-inhibit -w &
         exec-once = ${pkgs.waybar}/bin/waybar &
         exec-once = ${pkgs.gammastep}/bin/gammastep &
         exec-once = mullvad-gui &
         exec-once = ${pkgs.tailscale-systray}/bin/tailscale-systray &
         exec-once = ${pkgs.swaybg}/bin/swaybg -i ${config.my.settings.wallpaper} --mode fill &
         exec-once = pypr

         # █▀ █▀▀ █▀█ █ █▀█ ▀█▀ █▀
         # ▄█ █▄▄ █▀▄ █ █▀▀ ░█░ ▄█
         bindl=,switch:Lid Switch, exec, ${laptop_lid_switch}/bin/laptop_lid_switch

         # █░░ █▀█ █▀▀ █▄▀   █▀ █▀▀ █▀█ █▀▀ █▀▀ █▄░█
         # █▄▄ █▄█ █▄▄ █░█   ▄█ █▄▄ █▀▄ ██▄ ██▄ █░▀█
         bind=,XF86Launch5,exec,swaylock -S
         bind=,XF86Launch4,exec,swaylock -S
         bind=SUPER,backspace,exec,swaylock -S

         # █▀ █▀▀ █▀█ ▄▀█ ▀█▀ █▀▀ █░█ █▀█ ▄▀█ █▀▄
         # ▄█ █▄▄ █▀▄ █▀█ ░█░ █▄▄ █▀█ █▀▀ █▀█ █▄▀
         bind=SUPER,u,togglespecialworkspace
         bind=SUPERSHIFT,u,movetoworkspace,special

         # █▀ █▀▀ █▀█ █▀▀ █▀▀ █▄░█ █▀ █░█ █▀█ ▀█▀
         # ▄█ █▄▄ █▀▄ ██▄ ██▄ █░▀█ ▄█ █▀█ █▄█ ░█░
         bind=,Print,exec,grimblast --notify copysave area
         bind=SHIFT,Print,exec,grimblast --notify copy active
         bind=CONTROL,Print,exec,grimblast --notify copy screen
         bind=SUPER,Print,exec,grimblast --notify copy window
         bind=ALT,Print,exec,grimblast --notify copy area
         bind=SUPER,bracketleft,exec,grimblast --notify --cursor copysave area ~/Pictures/$(date "+%Y-%m-%d"T"%H:%M:%S_no_watermark").png
         bind=SUPER,bracketright,exec, grimblast --notify --cursor copy area

         # █▄▀ █▀▀ █▄█ █▄▄ █▀█ ▄▀█ █▀█ █▀▄   █▀▀ █▀█ █▄░█ ▀█▀ █▀█ █▀█ █░░ █▀
         # █░█ ██▄ ░█░ █▄█ █▄█ █▀█ █▀▄ █▄▀   █▄▄ █▄█ █░▀█ ░█░ █▀▄ █▄█ █▄▄ ▄█
         bindi=,XF86MonBrightnessUp,exec, brightness --inc
         bindi=,XF86MonBrightnessDown,exec, brightness --dec
         bindi=,XF86AudioRaiseVolume,exec, volume --inc
         bindi=,XF86AudioLowerVolume,exec, volume --dec
         bindi=,XF86AudioMute,exec, volume --toggle
         bindi=,XF86AudioMicMute,exec, volume --toggle-mic
         bindi=,XF86AudioNext,exec,playerctl next
         bindi=,XF86AudioPrev,exec,playerctl previous
         bindi=,XF86AudioPlay,exec,playerctl play-pause
         bindi=,XF86AudioStop,exec,playerctl stop
         bindi=ALT,XF86AudioNext,exec,playerctld shift
         bindi=ALT,XF86AudioPrev,exec,playerctld unshift
         bindi=ALT,XF86AudioPlay,exec,systemctl --user restart playerctld

         # █▀▀ █▀█ █▀▀ █░█ █▀
         # █▀░ █▄█ █▄▄ █▄█ ▄█
         bind=SUPER,h,movefocus,l
         bind=SUPER,l,movefocus,r
         bind=SUPER,k,movefocus,u
         bind=SUPER,j,movefocus,d

         # █▀ █░█░█ ▄▀█ █▀█   █░█░█ █ █▄░█ █▀▄ █▀█ █░█░█ █▀
         # ▄█ ▀▄▀▄▀ █▀█ █▀▀   ▀▄▀▄▀ █ █░▀█ █▄▀ █▄█ ▀▄▀▄▀ ▄█
         bind=SUPERSHIFT,h,swapwindow,l
         bind=SUPERSHIFT,l,swapwindow,r
         bind=SUPERSHIFT,k,swapwindow,u
         bind=SUPERSHIFT,j,swapwindow,d

         # █▀▀ █▀█ █▀▀ █░█ █▀   █▀▄▀█ █▀█ █▄░█ █ ▀█▀ █▀█ █▀█
         # █▀░ █▄█ █▄▄ █▄█ ▄█   █░▀░█ █▄█ █░▀█ █ ░█░ █▄█ █▀▄
         bind=SUPERCONTROL,h,focusmonitor,l
         bind=SUPERCONTROL,l,focusmonitor,r
         bind=SUPERCONTROL,k,focusmonitor,u
         bind=SUPERCONTROL,j,focusmonitor,d

         # █▀▄▀█ █▀█ █░█ █▀▀   ▀█▀ █▀█   █▀▄▀█ █▀█ █▄░█ █ ▀█▀ █▀█ █▀█
         # █░▀░█ █▄█ ▀▄▀ ██▄   ░█░ █▄█   █░▀░█ █▄█ █░▀█ █ ░█░ █▄█ █▀▄
         bind=SUPERALT,h,movecurrentworkspacetomonitor,l
         bind=SUPERALT,l,movecurrentworkspacetomonitor,r
         bind=SUPERALT,k,movecurrentworkspacetomonitor,u
         bind=SUPERALT,j,movecurrentworkspacetomonitor,d

         # █▀▀ █░█ ▄▀█ █▄░█ █▀▀ █▀▀   █░█░█ █▀█ █▀█ █▄▀ █▀ █▀█ ▄▀█ █▀▀ █▀▀
         # █▄▄ █▀█ █▀█ █░▀█ █▄█ ██▄   ▀▄▀▄▀ █▄█ █▀▄ █░█ ▄█ █▀▀ █▀█ █▄▄ ██▄
         bind=SUPER,1,workspace,01
         bind=SUPER,2,workspace,02
         bind=SUPER,3,workspace,03
         bind=SUPER,4,workspace,04
         bind=SUPER,5,workspace,05
         bind=SUPER,6,workspace,06
         bind=SUPER,7,workspace,07
         bind=SUPER,8,workspace,08
         bind=SUPER,9,workspace,09
         bind=SUPER,0,workspace,10

         # █▀▄▀█ █▀█ █░█ █▀▀   ▀█▀ █▀█   █░█░█ █▀█ █▀█ █▄▀ █▀ █▀█ ▄▀█ █▀▀ █▀▀
         # █░▀░█ █▄█ ▀▄▀ ██▄   ░█░ █▄█   ▀▄▀▄▀ █▄█ █▀▄ █░█ ▄█ █▀▀ █▀█ █▄▄ ██▄
         bind=SUPERSHIFT,1,movetoworkspacesilent,01
         bind=SUPERSHIFT,2,movetoworkspacesilent,02
         bind=SUPERSHIFT,3,movetoworkspacesilent,03
         bind=SUPERSHIFT,4,movetoworkspacesilent,04
         bind=SUPERSHIFT,5,movetoworkspacesilent,05
         bind=SUPERSHIFT,6,movetoworkspacesilent,06
         bind=SUPERSHIFT,7,movetoworkspacesilent,07
         bind=SUPERSHIFT,8,movetoworkspacesilent,08
         bind=SUPERSHIFT,9,movetoworkspacesilent,09
         bind=SUPERSHIFT,0,movetoworkspacesilent,10

         bind=ALTCTRL,L,movewindow,r
         bind=ALTCTRL,H,movewindow,l
         bind=ALTCTRL,K,movewindow,u
         bind=ALTCTRL,J,movewindow,d

         # █░█░█ █ █▄░█ █▀▄ █▀█ █░█░█   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀
         # ▀▄▀▄▀ █ █░▀█ █▄▀ █▄█ ▀▄▀▄▀   █░▀░█ █▀█ █░▀█ █▀█ █▄█ █░▀░█ ██▄ █░▀█ ░█░
         bind = SUPER, Q, killactive,
         bind = SUPER, F, fullscreen, 0
         bind = SUPER, F, exec, $notifycmd 'Fullscreen Mode'
         bind = SUPER, S, pseudo,
         bind = SUPER, S, exec, $notifycmd 'Pseudo Mode'
         bind = SUPER, Space, togglefloating,
         bind = SUPER, Space, centerwindow,

         # █▀▄▀█ █▀█ █░█ █▀ █▀▀   █▄▄ █ █▄░█ █▀▄ █ █▄░█ █▀▀
         # █░▀░█ █▄█ █▄█ ▄█ ██▄   █▄█ █ █░▀█ █▄▀ █ █░▀█ █▄█
         bindm=SUPER, mouse:272, movewindow
         bindm=SUPER, mouse:273, resizewindow

         # █▀█ █▀▀ █▀ █ ▀█ █▀▀
         # █▀▄ ██▄ ▄█ █ █▄ ██▄
         binde = SUPERALT, h, resizeactive, -20 0
         binde = SUPERALT, l, resizeactive, 20 0
         binde = SUPERALT, k, resizeactive, 0 -20
         binde = SUPERALT, j, resizeactive, 0 20

        bind=CTRL_SUPER,F,exec,pypr toggle yazi && hyprctl dispatch bringactivetotop
        bind=CTRL_SUPER,Z,exec,pypr toggle term && hyprctl dispatch bringactivetotop
        $scratchpadsize = size 80% 85%

        $scratchpad = class:^(scratchpad)$
        windowrulev2 = float,$scratchpad
        windowrulev2 = $scratchpadsize,$scratchpad
        windowrulev2 = workspace special silent,$scratchpad
        windowrulev2 = center,$scratchpad
      '';
    };
  };
}
