{
  fetchFromGitHub,
  lib,
  keystone,
  python3Packages,
  qt6,
  ...
}:
python3Packages.buildPythonPackage rec {
  pname = "mtkclient";
  version = "20241111";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "bkerler";
    repo = pname;
    rev = "77255c45bc1b6f5c789354e15738ccf7057e8cd1";
    hash = "sha256-6zVrke4PXt1EmyG9vDNoo6sMjuIarmcMq4j4MuMMER8=";
  };

  build-system = [
    python3Packages.hatchling
  ];

  nativeBuildInputs = [
    qt6.wrapQtAppsHook
  ];

  propagatedBuildInputs =
    with python3Packages;
    [
      capstone
      colorama
      flake8
      fusepy
      keystone-engine
      mock
      pycryptodome
      pycryptodomex
      pyserial
      pyside6
      pyusb
      setuptools
      shiboken6
      unicorn
    ]
    ++ [
      keystone
    ];

  buildInputs = [ qt6.qtwayland ];

  meta = with lib; {
    description = "MTK reverse engineering and flash tool";
    homepage = "https://github.com/bkerler/mtkclient";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ erikeah ];
  };
}
