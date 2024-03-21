{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.suites.desktop.addons.greetd;
in {
  options.suites.desktop.addons.greetd = {
    enable = mkEnableOption "Enable login greeter";
  };

  config = mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "Hyprland";
          #user = config.snowfallorg.user.name;
          user = "haseeb";
        };
      };
    };
  };
}
