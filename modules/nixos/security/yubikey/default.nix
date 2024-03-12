{pkgs, ...}: {
  services = {
    pcscd.enable = true;
    udev.packages = with pkgs; [yubikey-personalization];
    dbus.packages = [pkgs.gcr];
  };

  security.pam.services = {
    swaylock = {
      u2fAuth = true;
    };

    login = {
      u2fAuth = true;
    };

    sudo = {
      u2fAuth = true;
    };
  };
}
