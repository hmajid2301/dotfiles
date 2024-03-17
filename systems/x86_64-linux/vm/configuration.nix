{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  networking = {
    hostName = "vm";
  };

  modules.nixos = {
    avahi.enable = true;
    bluetooth.enable = true;
    docker.enable = true;
  };

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  system.stateVersion = "23.11";
}
