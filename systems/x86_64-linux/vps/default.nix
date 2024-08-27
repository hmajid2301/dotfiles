{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda1";

  services.openssh.enable = true;

  users.users.nixos = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    initialHashedPassword = "$y$j9T$2DyEjQxPoIjTkt8zCoWl.0$3mHxH.fqkCgu53xa0vannyu4Cue3Q7xL4CrUhMxREKC"; # Password.123
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    configure = {
      customRC = ''
        colorscheme habamax
      '';

      packages.packages = {
        start = [
          pkgs.vimPlugins.nerdtree
        ];
      };
    };
  };

  system.stateVersion = "24.05";
}
