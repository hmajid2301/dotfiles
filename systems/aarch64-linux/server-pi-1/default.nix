{lib, ...}: {
  imports = [
    ./hardware-configuration.nix
    # TODO: Get this work with Disko
    # ./disks.nix
  ];

  roles = {
    server.enable = true;
  };

  system.boot.enable = lib.mkForce false;
  hardware.raspberry-pi-5.enable = true;

  system.stateVersion = "23.11";
}
