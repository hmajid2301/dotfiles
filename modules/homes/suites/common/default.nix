{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.suites.common;
in {
  options.suites.common = {
    enable = mkEnableOption "Enable common configuration";
  };

  config = mkIf cfg.enable {
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
