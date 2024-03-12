{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.suites.common;
in {
  options.suites.common = {
    enable = mkEnableOption "Enable common configuration";
  };

  config = mkIf cfg.enable {
    nix = enabled;
  };
}
