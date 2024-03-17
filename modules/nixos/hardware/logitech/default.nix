{
  pkgs,
  lib,
  options,
  config,
  ...
}:
with lib; let
  cfg = config.hardware.logitech;
in {
  options.hardware.logitech = with types; {
    enable = mkBoolOpt false "Enable logitech hardware for their mice";
  };

  config = mkIf cfg.enable {
    hardware = {
      logitech.wireless.enable = true;
      logitech.wireless.enableGraphical = true; # Solaar.
    };

    environment.systemPackages = with pkgs; [
      solaar
    ];

    services.udev.packages = with pkgs; [
      logitech-udev-rules
      solaar
    ];
  };
}
