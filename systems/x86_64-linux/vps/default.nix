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

  services = {
    traefik = {
      dynamicConfigOptions = {
        http = {
          services = {
            jellyfin.loadBalancer.servers = [
              {
                url = "http://ms01:8096";
              }
            ];
          };

          routers = {
            homeassistant = {
              entryPoints = ["websecure"];
              rule = "Host(`jellyfin.haseebmajid.dev`)";
              service = "jellyfin";
              tls.certResolver = "letsencrypt";
            };
          };
        };
      };
    };
  };

  system.stateVersion = "24.05";
}