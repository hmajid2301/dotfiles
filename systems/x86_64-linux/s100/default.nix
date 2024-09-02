{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./disks.nix
  ];

  roles = {
    server.enable = true;
  };

  services.traefik = {
    dynamicConfigOptions = {
      http = {
        services.homeAssistant.loadBalancer.servers = [
          {
            url = "http://localhost:8123";
          }
        ];

        routers.homeAssistant = {
          entryPoints = ["websecure"];
          rule = "Host(`home-assistant.homelab.haseebmajid.dev`)";
          service = "homeAssistant";
          tls.certResolver = "letsencrypt";
        };
      };
    };
  };

  services.nixicle = {
    traefik.enable = true;
    postgresql.enable = true;
    home-assistant.enable = true;
    adguard.enable = true;
  };

  topology.self = {
    hardware.info = "S100";
  };

  boot = {
    supportedFilesystems = lib.mkForce ["btrfs"];
    kernelPackages = pkgs.linuxPackages_latest;
    resumeDevice = "/dev/disk/by-label/nixos";
  };

  system.stateVersion = "23.11";
}
