{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./disks.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda1";

  roles.server.enable = true;
  system.boot.enable = lib.mkForce false;

  system.stateVersion = "24.05";
}
