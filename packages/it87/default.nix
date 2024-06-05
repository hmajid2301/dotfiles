{
  lib,
  stdenv,
  fetchFromGitHub,
  kernel,
}:
stdenv.mkDerivation rec {
  name = "it87-${version}-${kernel.version}";
  version = "unstable-2022-02-26";

  # Original is no longer maintained.
  # This is the same upstream as the AUR uses.
  src = fetchFromGitHub {
    owner = "frankcrawford";
    repo = "it87";
    rev = "043eae2cad7ee26f05a38b5602dce3c207bf974a";
    sha256 = "";
  };

  hardeningDisable = ["pic"];

  nativeBuildInputs = kernel.moduleBuildDependencies;

  preConfigure = ''
    sed -i 's|depmod|#depmod|' Makefile
  '';

  makeFlags = [
    "TARGET=${kernel.modDirVersion}"
    "KERNEL_MODULES=${kernel.dev}/lib/modules/${kernel.modDirVersion}"
    "MODDESTDIR=$(out)/lib/modules/${kernel.modDirVersion}/kernel/drivers/hwmon"
  ];

  meta = with lib; {
    description = "Patched module for IT87xx superio chip sensors support";
    homepage = "https://github.com/hannesha/it87";
    license = licenses.gpl2Plus;
    platforms = ["x86_64-linux" "i686-linux"];
    maintainers = teams.lumiguide.members;
  };
}
