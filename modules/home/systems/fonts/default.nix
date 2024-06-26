{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nixicle; let
  cfg = config.system.fonts;
in {
  options.system.fonts = with types; {
    enable = mkBoolOpt false "Whether or not to manage fonts";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      (nerdfonts.override {fonts = ["JetBrainsMono"];})
      fontconfig
      fira-code-nerdfont
      noto-fonts
      (joypixels.override {acceptLicense = true;})
      noto-fonts-color-emoji
      twitter-color-emoji
      google-fonts
      open-sans
      zlib
    ];

    fonts.fontconfig.enable = lib.mkForce true;
  };
}
