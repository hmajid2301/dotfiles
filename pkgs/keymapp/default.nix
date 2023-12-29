{
  stdenv,
  lib,
  fetchurl,
  autoPatchelfHook,
  wrapGAppsHook,
  libusb1,
  webkitgtk,
  gtk3,
  writeShellScript,
  makeDesktopItem,
  copyDesktopItems,
}: let
  desktopItem = makeDesktopItem {
    name = "keymapp";
    icon = "keymapp";
    desktopName = "Keymapp";
    categories = ["Settings" "HardwareSettings"];
    type = "Application";
    exec = "keymapp";
  };
in
  stdenv.mkDerivation rec {
    pname = "keymapp";
    version = "1.0.6";

    src = fetchurl {
      url = "https://oryx.nyc3.cdn.digitaloceanspaces.com/keymapp/keymapp-${version}.tar.gz";
      hash = "sha256-ongauJuHAGgrzyE39Fz5oVuHR+/Hoi/mV5GQojsyAq4=";
    };

    nativeBuildInputs = [
      copyDesktopItems
      autoPatchelfHook
      wrapGAppsHook
    ];

    buildInputs = [
      libusb1
      webkitgtk
      gtk3
    ];

    sourceRoot = ".";

    installPhase = ''
      runHook preInstall

      install -m755 -D keymapp "$out/bin/${pname}"
      install -Dm644 ${./keymapp.png} "$out/share/pixmaps/keymapp.png"

      runHook postInstall
    '';

    preFixup = ''
      gappsWrapperArgs+=(--set-default '__NV_PRIME_RENDER_OFFLOAD' 1)
    '';

    desktopItems = [desktopItem];

    meta = with lib; {
      homepage = "https://www.zsa.io/flash/";
      description = "Application for ZSA keyboards";
      maintainers = with lib.maintainers; [jankaifer shawn8901];
      platforms = platforms.linux;
      license = lib.licenses.unfree;
    };
  }