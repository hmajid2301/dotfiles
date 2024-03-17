{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.services.ssh;
in {
  options.services.ssh = with types; {
    enable = mkBoolOpt false "Enable ssh";
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      ports = [22];

      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
        StreamLocalBindUnlink = "yes";
        GatewayPorts = "clientspecified";
      };
      passwordAuthentication = false;
    };

    home.persist.directories = [
      ".ssh"
    ];

    environment.persist.directories = [
      "/root/ssh"
    ];

    environment.persist.files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
    ];
  };
}
