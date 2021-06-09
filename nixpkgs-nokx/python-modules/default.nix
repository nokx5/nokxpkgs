python-self: python-super:

let
  inherit (python-super) callPackage lib;

  all-nokx = with python-self; [
    golden-pybind11
    golden-python
    golden-python_cli
    speedo
    speedo_client
  ];

in {
  inherit all-nokx;

  golden-pybind11 = callPackage ./golden-pybind11 { };

  inherit (callPackage ./golden-python { }) golden-python golden-python_cli;

  # disable test for fastapi
  starlette = python-super.starlette.overridePythonAttrs (oldAttrs: rec {
    checkPhase = ''
      pytest --ignore=tests/test_graphql.py --ignore=tests/middleware/test_errors.py
    '';
  });

  inherit (callPackage ./speedo { }) speedo speedo_client;

}
