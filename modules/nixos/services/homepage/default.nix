{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.services.nixicle.homepage;
in {
  options.services.nixicle.homepage = {
    enable = mkEnableOption "Enable homepage for homelab services";
  };

  config = mkIf cfg.enable {
    services.traefik = {
      dynamicConfigOptions = {
        http = {
          services.homepage.loadBalancer.servers = [
            {
              url = "http://localhost:8173";
            }
          ];

          routers = {
            homepage = {
              entryPoints = ["websecure"];
              rule = "Host(`homepage.bare.homelab.haseebmajid.dev`)";
              service = "homepage";
              tls.certResolver = "letsencrypt";
              middlewares = ["authentik"];
            };
          };
        };
      };
    };

    services.homepage-dashboard = {
      enable = true;
      # environmentFile = config.age.secrets.dashboard-env.path;
      listenPort = 8173;
      bookmarks = [];
      services = [
        {
          media = [
            {
              Jellyfin = {
                icon = "jellyfin.png";
                href = "{{HOMEPAGE_VAR_JELLYFIN_URL}}";
                description = "media management";
                widget = {
                  type = "jellyfin";
                  url = "{{HOMEPAGE_VAR_JELLYFIN_URL}}";
                  key = "{{HOMEPAGE_VAR_JELLYFIN_API_KEY}}";
                };
              };
            }
            {
              Radarr = {
                icon = "radarr.png";
                href = "{{HOMEPAGE_VAR_RADARR_URL}}";
                description = "film management";
                widget = {
                  type = "radarr";
                  url = "{{HOMEPAGE_VAR_RADARR_URL}}";
                  key = "{{HOMEPAGE_VAR_RADARR_API_KEY}}";
                };
              };
            }
            {
              Sonarr = {
                icon = "sonarr.png";
                href = "{{HOMEPAGE_VAR_SONARR_URL}}";
                description = "tv management";
                widget = {
                  type = "sonarr";
                  url = "{{HOMEPAGE_VAR_SONARR_URL}}";
                  key = "{{HOMEPAGE_VAR_SONARR_API_KEY}}";
                };
              };
            }
            {
              Lidarr = {
                icon = "Lidarr.png";
                href = "{{HOMEPAGE_VAR_SONARR_URL}}";
                description = "tv management";
                widget = {
                  type = "sonarr";
                  url = "{{HOMEPAGE_VAR_SONARR_URL}}";
                  key = "{{HOMEPAGE_VAR_SONARR_API_KEY}}";
                };
              };
            }
            {
              Readarr = {
                icon = "Readarr.png";
                href = "{{HOMEPAGE_VAR_SONARR_URL}}";
                description = "tv management";
                widget = {
                  type = "sonarr";
                  url = "{{HOMEPAGE_VAR_SONARR_URL}}";
                  key = "{{HOMEPAGE_VAR_SONARR_API_KEY}}";
                };
              };
            }
            {
              Prowlarr = {
                icon = "prowlarr.png";
                href = "{{HOMEPAGE_VAR_PROWLARR_URL}}";
                description = "index management";
                widget = {
                  type = "prowlarr";
                  url = "{{HOMEPAGE_VAR_PROWLARR_URL}}";
                  key = "{{HOMEPAGE_VAR_PROWLARR_API_KEY}}";
                };
              };
            }
          ];
        }
        {
          infra = [
            {
              Files = {
                description = "file manager";
                icon = "files.png";
                href = "https://files.jnsgr.uk";
              };
            }
            {
              "Syncthing (thor)" = {
                description = "syncthing ui for thor";
                icon = "syncthing.png";
                href = "https://thor.sync.jnsgr.uk";
              };
            }
            {
              "Syncthing (kara)" = {
                description = "syncthing ui for kara";
                icon = "syncthing.png";
                href = "https://kara.sync.jnsgr.uk";
              };
            }
            {
              "Syncthing (freyja)" = {
                description = "syncthing ui for freyja";
                icon = "syncthing.png";
                href = "https://freyja.sync.jnsgr.uk";
              };
            }
          ];
        }
      ];
      settings = {
        title = "sgrs dashboard";
        favicon = "https://jnsgr.uk/favicon.ico";
        headerStyle = "clean";
        layout = {
          media = {
            style = "row";
            columns = 3;
          };
          infra = {
            style = "row";
            columns = 4;
          };
          machines = {
            style = "row";
            columns = 4;
          };
        };
      };
      widgets = [
        {
          search = {
            provider = "custom";
            url = "https://kagi.com/search?q=";
            target = "_blank";
            suggestionUrl = "https://kagi.com/autocomplete?type=list&q="; # Optional
            showSearchSuggestions = true; # Optional
          };
        }
        {
          cloudflared = {
            type = "cloudflared";
            accountid = "{{HOMEPAGE_VAR_CLOUDFLARE_ACCOUNT_ID}}";
            tunnelid = "{{HOMEPAGE_VAR_CLOUDFLARE_TUNNEL_ID}}";
            key = "{{HOMEPAGE_VAR_CLOUDFLARE_KEY}}";
          };
        }
        {
          jellyseerr = {
            type = "jellyseerr";
            url = "{{HOMEPAGE_VAR_JELLYSEERR_URL}}";
            key = "{{HOMEPAGE_VAR_JELLYSEERR_API_KEY}}";
          };
        }
        {
          tailscale = {
            type = "tailscale";
            deviceid = "{{HOMEPAGE_VAR_TAILSCALE_DEVICE_ID}}";
            key = "{{HOMEPAGE_VAR_TAILSCALE_KEY}}";
          };
        }
        {
          resources = {
            label = "system";
            cpu = true;
            memory = true;
          };
        }
        {
          resources = {
            label = "storage";
            disk = ["/mnt/share/haseeb/homelab"];
          };
        }
        {
          openmeteo = {
            label = "London";
            timezone = "Europe/London";
            latitude = "{{HOMEPAGE_VAR_LATITUDE}}";
            longitude = "{{HOMEPAGE_VAR_LONGITUDE}}";
            units = "metric";
          };
        }
      ];
    };
  };
}
