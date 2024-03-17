{
  imports = [
    ./hardware-configuration.nix
  ];

  networking = {
    hostName = "vm";
  };

  services = {
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;
  };

  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
    useOSProber = true;
  };

  user = {
    name = "haseeb";
    initialPassword = "1";
  };

  system = {
    nix.enable = true;
  };

  system.stateVersion = "23.11";
}
