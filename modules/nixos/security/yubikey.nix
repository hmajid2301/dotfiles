{pkgs, ...}: {
  services = {
    pcscd.enable = true;
    udev.packages = with pkgs; [yubikey-personalization];
    dbus.packages = [pkgs.gcr];
  };
}
