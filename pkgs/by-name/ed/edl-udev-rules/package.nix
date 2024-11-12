{
  lib,
  stdenv,
  fetchFromGitHub,
  ...
}:

## Usage
# In NixOS, simply add this package to services.udev.packages:
# services.udev.packages = [ pkgs.edl-udev-rules ];

stdenv.mkDerivation rec {
  pname = "edl-udev-rules";
  version = "3.52.1";

  src =
    fetchFromGitHub {
      owner = "bkerler";
      repo = "edl";
      rev = version;
      hash = "sha256-Sr2d63OyQJtLjuVvPrLvNzj2owWAmx8+O+D+Awa8dLo=";
    }
    + "/Drivers";

  installPhase = ''
    runHook preInstall
    install -D 51-edl.rules $out/lib/udev/rules.d/51-edl.rules
    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/bkerler/edl";
    description = "Edl udev rules";
    platforms = platforms.linux;
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ erikeah ];
  };
}
