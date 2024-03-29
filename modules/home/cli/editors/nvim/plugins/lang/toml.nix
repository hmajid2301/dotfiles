{config, ...}: {
  programs.nixvim = {
    plugins.lsp.servers.taplo = {
      enable = true;
    };

    plugins.treesitter = {
      grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
        toml
      ];
    };
  };
}
