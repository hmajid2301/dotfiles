{ pkgs
, inputs
, lib
, config
, ...
}: {
  imports = [
    ../../home-manager
  ];

  config = {
    my.settings = {
      wallpaper = "~/Pictures/wallpapers/nixppuccin.png";
      host = "curve";
      default = {
        shell = "${pkgs.fish}/bin/fish";
        terminal = "wezterm";
        browser = "firefox";
        editor = "nvim";
      };
    };

    colorscheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

    home = {
      username = lib.mkDefault "haseebmajid";
      homeDirectory = lib.mkDefault "/home/${config.home.username}";
      stateVersion = lib.mkDefault "23.05";
    };

    modules = {
      browsers = {
        firefox.enable = true;
      };

      editors = {
        nvim.enable = true;
      };

      multiplexers = {
        tmux.enable = true;
      };

      wms = {
        hyprland.enable = true;
      };

      shells = {
        fish.enable = true;
      };

      terminals = {
        foot.enable = true;
        wezterm.enable = true;
      };
    };

    # USE Gnome
    # To show nix installed apps in Gnome
    targets.genericLinux.enable = true;
    xdg.mime.enable = true;
    xdg.systemDirs.data = [ "${config.home.homeDirectory}/.nix-profile/share/applications" ];

    xdg.configFile."autostart/tailscale.desktop".text = ''
      	[Desktop Entry]
      	Type=Application
      	Exec=tailscale-systray
      	Hidden=false
      	NoDisplay=false
      	X-GNOME-Autostart-enabled=true
      	Comment[en_NG]=Start Tailscale Systray
    '';

    # Work Laptop different email
    programs.git.userEmail = lib.mkForce "haseeb.majid@imaginecurve.com";
    programs.git.extraConfig."url \"git@git.curve.tools:\"" = { insteadOf = https://git.curve.tools/; };
    programs.git.extraConfig."url \"git@gitlab.com:imaginecurve/\"" = { insteadOf = https://gitlab.com/imaginecurve/; };
    programs.git.extraConfig."url \"git@gitlab.com:\"" = { insteadOf = https://gitlab.com/; };
    programs.git.extraConfig.core.excludesfile = "~/.config/git/ignore";
    xdg.configFile."git/ignore".text = ''
      projects/**/**/flake.nix
      projects/**/**/flake.lock
    '';

    wayland.windowManager.hyprland.extraConfig = lib.mkAfter ''
      exec-once = /usr/libexec/geoclue-2.0/demos/agent
      exec-once = warp-taskbar

      bind=,XF86Launch5,exec,/usr/local/bin/swaylock -S
      bind=,XF86Launch4,exec,/usr/local/bin/swaylock -S
      bind=SUPER,backspace,exec,/usr/local/bin/swaylock -S
    '';

    home.packages = with pkgs; [
      podman-compose
      podman-tui
    ];
    gtk.iconTheme = lib.mkForce {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };
  };
}
