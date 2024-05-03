{
  lib,
  config,
  ...
}:
with lib;
with lib.nixicle; let
  cfg = config.roles.desktop;
in {
  options.roles.desktop = {
    enable = mkEnableOption "Enable desktop configuration";
  };

  config = mkIf cfg.enable {
    roles = {
      common.enable = true;

      desktop.addons = {
        nautilus.enable = true;
      };
    };

    hardware = {
      logitechMouse.enable = true;
      zsa.enable = true;
    };

    services = {
      nixicle.avahi.enable = true;
      backup.enable = true;
      vpn.enable = true;
      virtualisation.podman.enable = true;
    };

    cli.programs = {
      nh.enable = true;
      nix-ld.enable = true;
    };

    user = {
      name = "haseeb";
      initialPassword = "1";
    };
  };
}