{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  suites = {
    desktop.enable = true;
  };

  nixicile.user = {
    enable = true;
    name = "haseeb";
  };

  home.stateVersion = "23.11";
}
