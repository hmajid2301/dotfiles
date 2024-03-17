{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.hardware.bluetooth;
in {
  options.hardware.bluetooth = {
    enable = mkEnableOption "Enable bluetooth service and packages";
  };

  config = mkIf cfg.enable {
    services.blueman.enable = true;
    hardware = {
      bluetooth = {
        enable = true;
        powerOnBoot = false;
        settings = {
          General = {
            Experimental = true;
          };
        };
      };
    };
  };
}
