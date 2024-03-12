{
  options,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.desktop.hyprland;
in {
  options.desktop.hyprland = with types; {
    enable = mkBoolOpt false "Enable or disable the hyprland window manager.";
  };

  config = mkIf cfg.enable {
    programs.hyprland.enable = true;
  };
}
