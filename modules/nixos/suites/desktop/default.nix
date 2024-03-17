{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.suites.desktop;
in {
  options.suites.desktop = {
    enable = mkEnableOption "Enable desktop configuration";
  };

  config = mkIf cfg.enable {
    suites = {
      common.enable = true;
      desktop.addon = {
        nautilus.enable = true;
        hyprland.enable = true;
      };
      virtualisation = {
        podman.enable = true;
      };
    };
  };
}
