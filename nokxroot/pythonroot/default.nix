super: python-self:

let
  inherit (python-self) callPackage;

  inherit (super) stdenv;
  inherit (stdenv) lib;

in python-super: {

  golden_binding = callPackage ./golden_binding { };

  inherit (callPackage ./golden_python { }) golden_python golden_python_cli;

}
