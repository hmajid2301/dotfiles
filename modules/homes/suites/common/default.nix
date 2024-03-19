{
  lib,
  config,
  inputs,
  ...
}:
with lib;
with inputs; let
  cfg = config.suites.common;
in {
  imports = [nix-colors.homeManagerModule];

  options.suites.common = {
    enable = mkEnableOption "Enable common configuration";
  };

  config = mkIf cfg.enable {
    colorscheme = nix-colors.colorSchemes.catppuccin-mocha;

    nix.enable = true;
    suites.guis.enable = true;
    cli.terminals.wezterm.enable = true;
    cli.shells.fish.enable = true;

    # TODO: move this to a separate module
    home.packages = with pkgs; [
      keymapp
      powertop

      nix-your-shell
      src-cli

      (lib.hiPrio parallel)
      moreutils
      nvtop-amd
      htop
      unzip
      gnupg

      showmethekey
    ];
  };
}
