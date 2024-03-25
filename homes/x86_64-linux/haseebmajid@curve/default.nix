{lib, ...}: {
  suites = {
    desktop.enable = true;
  };

  desktops.addon = {
    gnome.enable = true;

    swaylock = {
      enable = true;
      blur = "25x20";
      vignette = "0.5x0.5";
      binary = "/usr/local/bin/swaylock";
    };

    cli.programs.git = {
      email = "haseeb.majid@imaginecurve.com";
      extraConfig = {
        "url \"git@gitlab.com:imaginecurve/\"" = {insteadOf = "https://gitlab.com/imaginecurve/";};
        "url \"git@gitlab.com:\"" = {insteadOf = "https://gitlab.com/";};
      };
    };
  };

  wayland.windowManager.hyprland.keyBinds.bind."SUPER, Return" = "exec,nixGL -- wezterm";
  wayland.windowManager.hyprland.keyBinds.bindi = lib.mkForce {};

  nixicle.user = {
    enable = true;
    name = "haseebmajid";
  };

  home.stateVersion = "23.11";
}
