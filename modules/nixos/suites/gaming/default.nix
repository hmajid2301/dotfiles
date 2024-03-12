{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.suites.gaming;
in {
  options.suites.gaming = with types; {
    enable = mkBoolOpt false "Enable the gaming suite";
  };

  config = mkIf cfg.enable {
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        mesa
      ];
    };

    nix.settings = {
      substituters = ["https://nix-gaming.cachix.org"];
      trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
    };

    hardware.xpadneo.enable = true;
    hardware.xone.enable = true;
    services.ratbagd.enable = true;

    programs = {
      gamemode.enable = true;
      gamescope.enable = true;
      steam = {
        enable = true;
        dedicatedServer.openFirewall = true;
        remotePlay.openFirewall = true;
        gamescopeSession.enable = true;
        extraCompatPackages = [
          inputs.nix-gaming.packages.${pkgs.system}.proton-ge
        ];
      };
    };

    environment.systemPackages = with pkgs; [
      winetricks
      wineWowPackages.waylandFull
    ];
  };
}
