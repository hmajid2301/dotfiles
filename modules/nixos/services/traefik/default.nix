{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.services.nixicle.traefik;
in {
  options.services.nixicle.traefik = {
    enable = mkEnableOption "Enable traefik";
  };

  systemd.services.traefik = {
    environment = {
      CF_API_EMAIL = "hello@haseebmajid.dev";
    };
    serviceConfig = {
      EnvironmentFile = [config.age.secrets.cloudflare_api_key.path];
    };
  };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [80 443];

    sops.secrets.cloudflare_api_key = {
      sopsFile = ../secrets.yaml;
    };

    services = {
      tailscale.permitCertUid = "traefik";

      traefik = {
        enable = true;
        staticConfigOptions = {
          certificatesResolvers = {
            tailscale.tailscale = {};
            cloudflare = {
              acme = {
                email = "hello@haseebmajid.dev";
                storage = "/var/lib/traefik/cert.json";
                dnsChallenge = {
                  provider = "cloudflare";
                };
              };
            };
          };

          entryPoints.web = {
            address = ":80";
            http.redirections.entryPoint = {
              to = "websecure";
              scheme = "https";
              permanent = true;
            };
          };
          entryPoints.websecure.address = ":443";
        };
      };
    };
  };
}
