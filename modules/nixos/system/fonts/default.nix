{
  options,
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
    enable = mkBoolOpt false "Whether or not to manage fonts.";
    fonts = mkOpt (listOf package) [] "Custom font packages to install.";
  };

  config = mkIf cfg.enable {
    environment.variables = {
      LOG_ICONS = "true";
    };

    environment.systemPackages = with pkgs; [font-manager];

    nixpkgs.config.joypixels.acceptLicense = true;
    fonts = {
      enableDefaultPackages = false;
      fontDir.enable = true;
      packages = with pkgs;
        [
          (nerdfonts.override {fonts = ["FiraCode" "SourceCodePro" "UbuntuMono"];})
          fira
          fira-go
          joypixels
          liberation_ttf
          noto-fonts-emoji
          source-serif
          ubuntu_font_family
          work-sans
          noto-fonts
          noto-fonts-cjk
          noto-fonts-emoji
          liberation_ttf
          fira-code
          fira-code-symbols
          fira-code-nerdfont
          roboto
          ubuntu_font_family
          oxygenfonts
          cantarell-fonts
          open-sans
          mplus-outline-fonts.githubRelease
          dina-font
          proggyfonts
        ]
        ++ cfg.fonts;

      fontconfig = {
        antialias = true;
        defaultFonts = {
          serif = ["Source Serif"];
          sansSerif = ["Work Sans" "Fira Sans" "FiraGO"];
          monospace = ["FiraCode Nerd Font Mono" "SauceCodePro Nerd Font Mono"];
          emoji = ["Joypixels" "Noto Color Emoji"];
        };
        enable = true;
        hinting = {
          autohint = false;
          enable = true;
          style = "slight";
        };
        subpixel = {
          rgba = "rgb";
          lcdfilter = "light";
        };
      };
    };
  };
}
