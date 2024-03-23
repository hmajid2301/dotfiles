{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  suites = {
    desktop.enable = true;
    gaming.enable = true;
  };

  desktops.hyprland.enable = true;

  nixicle.user = {
    enable = true;
    name = "haseeb";
  };

  home.stateVersion = "23.11";
}