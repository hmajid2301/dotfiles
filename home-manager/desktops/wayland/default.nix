{ inputs, config, pkgs, ... }: {
  imports = [
    ./eww.nix
    ./gammastep.nix
    ./mako.nix
    ./kanshi.nix
    ./rofi.nix
    ./swaylock.nix
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
    brightnessctl
    xdg-utils
    gnome.nautilus
    gnome.sushi
    gnome.gnome-disk-utility
    gnome.gedit
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