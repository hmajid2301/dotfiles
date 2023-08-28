{pkgs, ...}: {
  imports = [
    #./eww.nix
    ./gammastep.nix
    ./mako.nix
    ./kanshi.nix
    ./rofi.nix
    ./swaylock.nix
    ./wlogout.nix
    ./waybar
    #./xdg.nix
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland";
    LIBSEAT_BACKEND = "logind";
  };

  home.packages = with pkgs; [
    mplayer
    celluloid
    via
    mtpfs
    jmtpfs
    brightnessctl
    xdg-utils
    nautilus-open-any-terminal
    gnome.sushi
    gnome.nautilus
    gnome.gnome-disk-utility
    gnome.totem
    gnome.eog
    gnome.gvfs
    wl-clipboard
    pamixer
    playerctl
    sway-contrib.grimshot
    swaybg
  ];
}
