{ 
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    crane.url = "github:ipetkov/crane";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
  };

  outputs = { self, nixpkgs, rust-overlay, flake-utils, crane, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
        cargoToml = "${self}/Cargo.toml";
        cargoTomlConfig = builtins.fromTOML (builtins.readFile cargoToml);
      in
      rec {
        devShells = {
          default = pkgs.mkShell (rec {
            buildInputs = with pkgs; [ 
              pkg-config
              packages.clib
              pkgs.rust-bin.stable.${cargoTomlConfig.package.rust-version}.minimal
            ];
            nativeBuildInputs = with pkgs; [ 
              pkg-config
              packages.clib
            ];
            LIB = packages.clib;
          });
        };
        packages = {
          clib = pkgs.callPackage ./nix/clib.nix {};
        };
      }
    );
}
