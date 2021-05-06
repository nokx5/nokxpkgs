super: self:

rec {
  cherix = {
    golden_cpp = super.golden_cpp.override { stdenv = self.clangStdenv; };
  };
  hello = cherix.golden_cpp;
}
