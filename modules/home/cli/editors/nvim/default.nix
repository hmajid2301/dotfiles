{
  pkgs,
  lib,
  inputs,
  config,
  ...
}:
with lib;
with lib.nixicle; let
  cfg = config.cli.editors.nvim;
in {
  imports = with inputs; [
    nixvim.homeManagerModules.nixvim
  ];

  options.cli.editors.nvim = with types; {
    enable = mkBoolOpt false "enable neovim editor";
  };

  config =
    mkIf
    cfg.enable
    {
      home.file."./.config/nvim" = {
        source = ./config;
        recursive = true;
      };

      programs.nixvim = {
        enable = true;
        extraPlugins = with pkgs.vimPlugins; [plenary-nvim];
      };
    };
}
