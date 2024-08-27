{
  pkgs,
  lib,
  ...
}: {
  services = {
    nixicle = {
      tailscale.enable = true;
      traefik.enable = true;
    };
  };

  topology.self = {
    hardware.info = "flyvps";
  };

  system.stateVersion = "23.11";
}
