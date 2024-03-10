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
    nixvim.url = "github:pta2002/nixvim";

    impermanence.url = "github:nix-community/impermanence";
    lanzaboote.url = "github:nix-community/lanzaboote";

    nixgl.url = "github:nix-community/nixGL";
    nix-colors.url = "github:misterio77/nix-colors";

    hypr-contrib.url = "github:hyprwm/contrib";
    hyprland-nix.url = "github:spikespaz/hyprland-nix";

    nwg-displays.url = "github:nwg-piotr/nwg-displays";
    comma.url = "github:nix-community/comma";
    nix-gaming.url = "github:fufexan/nix-gaming";

    firefox-gnome-theme = {
      url = "github:rafaelmardojai/firefox-gnome-theme";
      flake = false;
    };
  };

  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      src = ./.;
      snowfall = {
        metadata = "nixicle";
        meta = {
          name = "nixicle";
          title = "Haseeb's Nix Flake";
        };
      };

      channels-config = {
        allowUnfree = true;
      };

      systems.modules.nixos = with inputs; [
        inputs.home-manager.nixosModules.home-manager
        inputs.disko.nixosModules.disko
        inputs.lanzaboote.nixosModules.lanzaboote
        inputs.sops-nix.nixosModules.sops
      ];

      systems.hosts.framework.modules = with inputs; [
        inputs.hardware.nixosModules.framework-13-7040-amd
      ];
    };
}
