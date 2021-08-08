{ pkgs ? import <nixpkgs> { config.allowUnfree = true; } }:

with pkgs;
assert hostPlatform.isx86_64;

let
  vscodeExt = vscode-with-extensions.override {
    vscodeExtensions = with vscode-extensions;
      [ bbenoist.nix eamodio.gitlens ]
      ++ vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "emacs-mcx";
          publisher = "tuttieee";
          version = "0.31.0";
          sha256 = "McSWrOSYM3sMtZt48iStiUvfAXURGk16CHKfBHKj5Zk=";
        }
      ];
  };
in
(mkShell.override {
  stdenv = stdenvNoCC;
})
{
  nativeBuildInputs = [ gnumake ] ++ [
    bashCompletion
    cacert
    git
    gnumake
    nixpkgs-fmt
    nix
    pkg-config
    emacs-nox
  ] ++ lib.optionals (hostPlatform.isLinux) [ typora vscodeExt ];

  shellHook = ''
    export SSL_CERT_FILE=${cacert}/etc/ssl/certs/ca-bundle.crt
  '';

}
