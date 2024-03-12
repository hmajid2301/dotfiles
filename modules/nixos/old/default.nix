{
  pkgs,
  inputs,
  outputs,
  lib,
  config,
  ...
}: {
  imports = [
    ./auto-upgrade.nix
    ./locale.nix
    ./nix.nix
    ./hardware.nix
    ./fonts.nix
    ./openssh.nix
    ./opengl.nix
    ./pam.nix
    ./sops.nix

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

  programs.hyprland.enable = true;

  system.nixos.label = lib.concatStringsSep "-" (
    (lib.sort (x: y: x < y) config.system.nixos.tags)
    ++ ["${config.system.nixos.version}.${inputs.self.sourceInfo.shortRev or "dirty"}"]
    ++ (lib.match "(.{4})(.{2})(.{2}).*" inputs.self.lastModifiedDate)
  );

  services = {
    pcscd.enable = true;
    udev.packages = with pkgs; [yubikey-personalization];
    gvfs.enable = true;
    udisks2.enable = true;
    fwupd.enable = true;
    dbus.packages = [pkgs.gcr];
  };

  environment.sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 = lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" (with pkgs.gst_all_1; [
    gst-plugins-good
    gst-plugins-bad
    gst-plugins-ugly
    gst-libav
  ]);
}
