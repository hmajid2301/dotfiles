{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.roles.common;
in {
  options.roles.common = {
    enable = mkEnableOption "Enable common configuration";
  };

  config = mkIf cfg.enable {
    hardware = {
      audio.enable = true;
      bluetooth.enable = true;
      networking.enable = true;
    };

    services = {
      openssh.enable = true;
    };

    security = {
      sops.enable = true;
      yubikey.enable = true;
    };

    system = {
      nix.enable = true;

      boot = {
        enable = true;
        plymouth = true;
      };

      fonts.enable = true;
      locale.enable = true;
    };
  };
}