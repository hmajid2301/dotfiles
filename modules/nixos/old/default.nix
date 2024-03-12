{
  pkgs,
  inputs,
  outputs,
  lib,
  config,
  ...
}: {
  imports = [
    ./hardware.nix
    ./fonts.nix
    ./openssh.nix

    ./optional/avahi.nix
    ./optional/auto-hibernate.nix
    ./optional/backup.nix
    ./optional/bluetooth.nix
    ./optional/docker.nix
    ./optional/hardening.nix
    ./optional/fingerprint.nix
    ./optional/greetd.nix
    ./optional/gaming.nix
    ./optional/power.nix
    ./optional/virtualisation.nix
    ./optional/vpn.nix
  ];
}
