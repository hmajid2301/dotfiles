{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with lib.nixicile; let
  cfg = config.cli.editors.nvim;
in {
  imports = with inputs; [
    nixvim.homeManagerModules.nixvim

    ./keymaps.nix
    ./options.nix
    ./autocmds.nix
    ./reload.nix

    ./plugins/debug.nix
    ./plugins/coding.nix
    ./plugins/editor.nix
    ./plugins/git.nix
    ./plugins/startup.nix
    ./plugins/test.nix

    ./plugins/lsp.nix
    ./plugins/treesitter.nix

    ./plugins/colorscheme.nix
    ./plugins/ui.nix

    ./plugins/ai
    ./plugins/training.nix
    ./plugins/notes.nix

    ./plugins/lang/css.nix
    ./plugins/lang/docker.nix
    ./plugins/lang/go.nix
    ./plugins/lang/helm.nix
    ./plugins/lang/lua.nix
    ./plugins/lang/kdl.nix
    ./plugins/lang/json.nix
    ./plugins/lang/html.nix
    ./plugins/lang/nix.nix
    ./plugins/lang/markdown.nix
    ./plugins/lang/python.nix
    ./plugins/lang/sql.nix
    ./plugins/lang/terraform.nix
    ./plugins/lang/typescript.nix
    ./plugins/lang/yaml.nix
  ];

  options.cli.editors.nvim = {
    enable = mkBoolOpt "enable neovim editor";
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
