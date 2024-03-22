{
  description = "Haseeb's Nix/NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko.url = "github:nix-community/disko";
    hardware.url = "github:nixos/nixos-hardware";
    sops-nix.url = "github:mic92/sops-nix";

    impermanence.url = "github:nix-community/impermanence";
    lanzaboote.url = "github:nix-community/lanzaboote";

    nixgl.url = "github:nix-community/nixGL";
    nix-colors.url = "github:misterio77/nix-colors";
    nix-ld.url = "github:Mic92/nix-ld";
    nix-index-database.url = "github:nix-community/nix-index-database";
    comma.url = "github:nix-community/comma";

    hypr-contrib.url = "github:hyprwm/contrib";
    hyprland-nix.url = "github:spikespaz/hyprland-nix";
    hypridle.url = "github:hyprwm/Hypridle";
    hyprlock.url = "github:hyprwm/Hyprlock";
    hyprpaper.url = "github:hyprwm/hyprpaper";

    nixvim.url = "github:pta2002/nixvim";

    firefox-gnome-theme = {
      url = "github:rafaelmardojai/firefox-gnome-theme";
      flake = false;
    };

    copilotchat-nvim = {
      url = "github:copilotc-nvim/copilotchat.nvim";
      flake = false;
    };

    neorg-templates = {
      url = "github:pysan3/neorg-templates";
      flake = false;
    };
  };

  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      src = ./.;
      snowfall = {
        metadata = "nixicle";
        namespace = "nixicle";
        meta = {
          name = "nixicle";
          title = "Haseeb's Nix Flake";
        };
      };

      channels-config = {
        allowUnfree = true;
      };

      systems.modules.nixos = with inputs; [
        home-manager.nixosModules.home-manager
        disko.nixosModules.disko
        lanzaboote.nixosModules.lanzaboote
        impermanence.nixosModules.impermanence
        sops-nix.nixosModules.sops
        nix-ld.nixosModules.nix-ld
      ];

      systems.hosts.framework.modules = with inputs; [
        hardware.nixosModules.framework-13-7040-amd
      ];

      # TODO: move to relevant files
      # homes.modules = with inputs; [
      #   impermanence.nixosModules.home-manager.impermanence
      # ];

      overlays = with inputs; [
        nixgl.overlay
      ];
    };
}
