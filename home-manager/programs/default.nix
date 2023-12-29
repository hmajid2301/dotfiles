{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./attic.nix
    ./atuin.nix
    ./bat.nix
    ./bottom.nix
    ./cheat-sheets.nix
    ./direnv.nix
    ./discord.nix
    ./eza.nix
    ./fonts.nix
    ./fzf.nix
    ./gaming.nix
    ./git.nix
    ./gpg.nix
    ./k8s.nix
    ./modern-unix.nix
    ./kafka.nix
    ./kdeconnect.nix
    ./modern-unix.nix
    ./yazi.nix
    ./photos.nix
    ./starship.nix
    ./spotify.nix
    ./zoxide.nix
  ];

  home.packages = with pkgs; [
    keymapp
    powertop

    nix-your-shell
    src-cli

    (lib.hiPrio parallel)
    moreutils
    nvtop-amd
    htop
    ctpv
    unzip
    gnupg

    showmethekey
  ];
}
