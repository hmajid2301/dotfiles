{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./disks.nix
  ];

  services = {
    media-server.enable = true;
    nixicle.gitlab-runner.enable = true;
  };

  roles = {
    kubernetes = {
      enable = true;
      role = "agent";
    };
  };

  # networking.interfaces.enp1s0.wakeOnLan.enable = true;

  boot = {
    supportedFilesystems = lib.mkForce ["btrfs"];
    kernelPackages = pkgs.linuxPackages_latest;
    resumeDevice = "/dev/disk/by-label/nixos";

    kernel.sysctl = {
      "fs.inotify.max_user_watches" = "2099999999";
      "fs.inotify.max_user_instances" = "2099999999";
      "fs.inotify.max_queued_events" = "2099999999";
    };
  };

  system.stateVersion = "23.11";
}
