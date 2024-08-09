{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.services.nixicle.ollama;
in {
  options.services.nixicle.ollama = {
    enable = mkenableoption "enable ollama and web ui";
  };

  config = mkif cfg.enable {
    services.ollama = {
      enable = true;
    };

    # services.open-webui = {
    #   enable = true;
    #   port = 8084;
    # };
  };
}
