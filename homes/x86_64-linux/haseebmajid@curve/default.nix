{
  pkgs,
  lib,
  config,
  ...
}: {
  wayland.windowManager.hyprland.keyBinds.bindi = lib.mkForce {};

  suites = {
    desktop.enable = true;
  };

  desktops.addon = {
    gnome.enable = true;

    swaylock = {
      enable = true;
      blur = "25x20";
      vignette = "0.5x0.5";
      swaylockBinary = "/usr/local/bin/swaylock";
    };
  };

  nixicle.user = {
    enable = true;
    name = "haseebmajid";
  };

  home.stateVersion = "23.11";

  # Work Laptop different email
  programs = {
    git = {
      userEmail = lib.mkForce "haseeb.majid@imaginecurve.com";
      extraConfig = {
        "url \"git@git.curve.tools:\"" = {insteadOf = "https://git.curve.tools/";};
        "url \"git@gitlab.com:imaginecurve/\"" = {insteadOf = "https://gitlab.com/imaginecurve/";};
        "url \"git@gitlab.com:\"" = {insteadOf = "https://gitlab.com/";};
        core.excludesfile = "~/.config/git/ignore";
      };
    };
  };

  wayland.windowManager.hyprland.extraConfig = lib.mkAfter ''
    exec-once = /usr/libexec/geoclue-2.0/demos/agent
    exec-once = warp-taskbar

    bind=,XF86Launch5,exec,/usr/local/bin/swaylock -S
    bind=,XF86Launch4,exec,/usr/local/bin/swaylock -S
    bind=SUPER,backspace,exec,/usr/local/bin/swaylock -S
    bind=SUPER,return,exec,nixGL -- wezterm
  '';
}
