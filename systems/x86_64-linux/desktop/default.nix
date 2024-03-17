{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ../../nixos
    ../../nixos/users/haseeb.nix
  ];

  networking = {
    hostName = "desktop";
  };

  virtualisation = {
  };

  modules.nixos = {
    avahi.enable = true;
    auto-hibernate.enable = false;
    backup.enable = true;
    bluetooth.enable = true;
    docker.enable = true;
    gaming.enable = true;
    login.enable = true;
    extraSecurity.enable = true;
    power.enable = true;
    virtualisation.enable = true;
    vpn.enable = true;
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
