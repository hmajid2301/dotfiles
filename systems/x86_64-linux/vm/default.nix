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
    enable = true;
    name = "haseeb";
  };

  system.stateVersion = "23.11";
}
