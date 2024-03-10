{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.multiplexers.zellij;
  inherit (config.colorscheme) colors;
in {
  options.modules.multiplexers.zellij = {
    enable = mkEnableOption "enable zellij multiplexer";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.tmate
      inputs.zjstatus.packages.${pkgs.system}.default
    ];

    xdg.configFile = {
      "zellij/config.kdl".source = ./config.kdl;
      "zellij/layouts/mine.kdl".text = ''
        layout {
        	pane size=1 borderless=true {
        		plugin location="zellij:compact-bar"
        	}
        	pane
        }
      '';
    };

    programs.zellij = {
      enable = true;
    };
  };
}
