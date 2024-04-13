{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          overlays = [ ];
          pkgs = import nixpkgs {
            inherit system overlays;
          };
        in
        with pkgs;
        {
          devShells.default = mkShell {
            buildInputs = [
              yarn
              cmake
              python3
            ];

            shellHook = ''
              export LD_LIBRARY_PATH="${
                lib.makeLibraryPath [
                  glib
                  glibc
                  nss
                  nspr
                  atk
                  cups
                  dbus
                  libdrm
                  gtk3
                  pango
                  cairo
                  xorg.libX11
                  xorg.libXcomposite
                  xorg.libXdamage
                  xorg.libXext
                  xorg.libXfixes
                  xorg.libXrandr
                  libxkbcommon
                  mesa
                  expat
                  xorg.libxcb
                  alsaLib
                  libGL
                  libsecret
                ]}"
            '';
          };
        }
      );
}
