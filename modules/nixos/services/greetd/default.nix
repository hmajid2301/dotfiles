{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.suites.desktop.greetd;
in {
  options.suites.desktop.greetd = {
    enable = mkEnableOption "Enable login greeter";
  };

  config = mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          # TODO: config
          command = "Hyprland";
          user = "haseeb";
        };
        default_session = initial_session;
      };
    };

    environment.etc."greetd/environments".text = ''
      Hyprland
    '';
  };
}
