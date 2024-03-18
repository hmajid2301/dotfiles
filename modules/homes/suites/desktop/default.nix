{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.suites.desktop;
in {
  options.suites.desktop = {
    enable = mkEnableOption "Enable desktop suite";
  };

  config = mkIf cfg.enable {
    suites = {
      common.enable = true;
      development.enable = true;
      gaming.enable = true;
    };
  };
}
