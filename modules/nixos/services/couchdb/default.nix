{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.nixicle.couchdb;
in {
  options.services.nixicle.couchdb = {
    enable = mkEnableOption "Enable CouchDB";
  };

  config = mkIf cfg.enable {
    services = {
      couchdb = {
        enable = true;
      };
    };
  };
}
