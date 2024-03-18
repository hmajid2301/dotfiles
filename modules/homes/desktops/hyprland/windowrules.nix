{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  rule = rules: attrs: attrs // {inherit rules;};
  cfg = config.desktops.hyprland;
in {
  options.desktops.hyprland = {
    enable = mkEnableOption "enable hyprland window manager";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.windowRules = let
      firefoxVideo = {
        class = ["firefox"];
      };
      guildWars = {
        title = ["Guild Wars 2"];
      };
    in
      lib.concatLists [
        (map (rule ["idleinhibit fullscreen"]) [firefoxVideo])
        (map (rule ["fullscreen"]) [guildWars])
      ];
  };
}
