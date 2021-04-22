{ stdenv, fetchgit, commonMeta, catch2, boost, cmake, gnumake, ninja }:

stdenv.mkDerivation rec {
  pname = "golden_cpp";
  version = "0.0.1";

  src = fetchgit {
    url = "https://github.com/nokx5/golden_cpp.git";
    rev = version;
    sha256 = "sha256:0kpd1cv4glg722a5a524lw25xwvcqjv34qyfrbw1p06gl9kh38d2";
  };

  buildInputs = [ boost ];

  nativeBuildInputs = [ catch2 cmake gnumake ninja ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    "-DPROJECT_TESTS=On"
    "-DPROJECT_SANDBOX=OFF"
  ];
  hardeningEnable = [ "format" "fortify" "pic" ];
  ninjaFlags = [ "-v" ];
  makeFlags = [ "VERBOSE=1" ];

  enableParallelBuilding = true;
  enableParallelChecking = true;

  doCheck = true;

  meta = commonMeta // { description = "Golden Project For Pure C++ Code"; };

}

