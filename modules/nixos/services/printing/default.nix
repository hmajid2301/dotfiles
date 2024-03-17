{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.services.printing;
in {
  options.services.printing = with types; {
    enable = mkBoolOpt false "Whether or not to configure printing support.";
  };

  config = mkIf cfg.enable {services.printing.enable = true;};
}
