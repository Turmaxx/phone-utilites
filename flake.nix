{
  description = "phone utility shell";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs @ { flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { pkgs, system, ... }: {
        formatter = pkgs.nixpkgs-fmt;
        devShells.default = pkgs.mkShell {
          name = "phone utility shell";
          packages = with pkgs; [
            # android
            simple-mtpfs
            # ios
            ifuse
            libimobiledevice
          ];
          shellHook = ''
            printf "This shell contains packages for phone utilities. packages are listed below:\n"
            printf "andriod - simple-mtpfs\n"
            printf "iphone  - ifuse libimobiledevice\n"
            printf "make sure you have the usbmuxd systemd service active or the package installed, running the systemd service is preferred.\n"
          '';
        };
      };
    };
}
