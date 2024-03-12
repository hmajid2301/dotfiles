{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.hardware.audio;
in {
  options.hardware.audio = with types; {
    enable = mkBoolOpt false "Enable or disable pipewire";
  };

  config = mkIf cfg.enable {
    # Enable sound with pipewire.
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
    programs.noisetorch.enable = true;
    environment.systemPackages = with pkgs; [
      headsetcontrol2
      headset-charge-indicator
      pavucontrol
      pulsemixer
    ];
    system.persist.home.dirs = [
      ".local/state/wireplumber"
    ];
  };
}
