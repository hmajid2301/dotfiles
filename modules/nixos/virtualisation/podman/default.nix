{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.virtualisation.podman;
in {
  options.virtualisation.podman = {
    enable = mkEnableOption "Enable podman";
  };

  config = mkIf cfg.enable {
    virtualisation = {
      podman = {
        enable = true;
        dockerSocket.enable = true;
        dockerCompat = true;
        defaultNetwork.settings = {
          dns_enabled = true;
        };
      };
    };
  };

  system.environment.persistence = {
    "/persist".directories = [
      "/var/lib/containers"
    ];
  };
}
