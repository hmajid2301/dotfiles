{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./disks.nix

    ../../nixos
    ../../nixos/users/haseeb.nix
  ];

  networking = {
    hostName = "desktop";
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

  environment.systemPackages = with pkgs; [
    headsetcontrol2
    headset-charge-indicator
  ];

  swapDevices = [{device = "/swap/swapfile";}];

  boot = {
    kernelParams = [
      "resume_offset=533760"
    ];
    supportedFilesystems = lib.mkForce ["btrfs"];
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    resumeDevice = "/dev/disk/by-label/nixos";
    initrd.systemd.enable = true;
  };

  system.stateVersion = "23.11";
}
