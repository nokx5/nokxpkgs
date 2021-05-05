{ buildPythonPackage, commonMeta, fetchgit, boost, cmake, ninja, numpy, pybind11
, pytest, sphinx, sphinx_rtd_theme }:

buildPythonPackage rec {
  pname = "golden_binding";
  version = "0.0.0";

  src = fetchgit {
    url = "https://github.com/nokx5/golden_binding.git";
    rev = version;
    sha256 = "sha256:112s4w9rpajhbv4ca72scn96rgydcfbn7wj9ymsbfm6x9ylcjp4q";
  };

  format = "other";

  nativeBuildInputs = [ cmake ninja ];

  buildInputs = [ boost pybind11 ];

  propagatedBuildInputs = [ numpy ];

  checkInputs = [ pytest ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    "-DPROJECT_TESTS=On"
    "-DPROJECT_SANDBOX=OFF"
  ];
  ninjaFlags = [ "-v" ];
  makeFlags = [ "VERBOSE=1" ];

  enableParallelBuilding = true;
  enableParallelChecking = true;

  installPhase = "ninja install";

  excludedTests = [ "test_python_interface" ];
  installCheckPhase = ''
    runHook preCheck
    ctest -V -E "${builtins.concatStringsSep "|" excludedTests}"
    export PYTHONPATH=$out/bin:$PYTHONPATH
    python -c "import pyview; import golden"
    pytest $src/tests/python -p no:cacheprovider
    runHook postCheck
  '';

  meta = commonMeta // {
    description = "Golden Project For Binding C++ To Python Code";
  };
}
