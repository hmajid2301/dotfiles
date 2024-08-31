{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.nixicle.stirling-pdf;
in {
  options.services.nixicle.stirling-pdf = {
    enable = mkEnableOption "Enable stirling pdf service";
  };

  config = mkIf cfg.enable {
    sops.secrets.gitea_smtp_password = {
      sopsFile = ../secrets.yaml;
      owner = "gitea";
    };

    services = {
      stirling-pdf = {
        enable = true;
        environment = {
          SERVER_PORT = 8783;
        };
      };

      traefik = {
        dynamicConfigOptions = {
          http = {
            services.pdf.loadBalancer.servers = [
              {
                url = "http://localhost:8783";
              }
            ];

            routers = {
              pdf = {
                entryPoints = ["websecure"];
                rule = "Host(`pdf.bare.homelab.haseebmajid.dev`)";
                service = "pdf";
                tls.certResolver = "letsencrypt";
              };
            };
          };
        };
      };
    };
  };
}
