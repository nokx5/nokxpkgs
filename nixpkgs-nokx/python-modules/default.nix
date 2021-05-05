python-self: python-super:

let
  inherit (python-super) callPackage lib;

  all-nokx = with python-self; [
    golden_binding
    golden_python
    golden_python_cli
  ];

in {
  inherit all-nokx;

  golden_binding = callPackage ./golden_binding { };

  inherit (callPackage ./golden_python { }) golden_python golden_python_cli;

}
