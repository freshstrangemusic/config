{
  description = "application-services flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snowflake = {
      url = "github:freshstrangemusic/snowflake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      rust-overlay,
      snowflake,
      ...
    }:
    snowflake.lib.forEachDefaultSystemWith
      {
        nixpkgsConfig = {
          allowUnfree = true;
          android_sdk.accept_license = true;
        };
        overlays = [ (import rust-overlay) ];
      }
      (
        { pkgs, system }:
        let
          toolchain = (
            pkgs.rust-bin.stable."1.94.0".default.override {
              extensions = [ "rust-src" ];
            }
          );
          androidPlatform = pkgs.androidenv.composeAndroidPackages {
            includeNDK = true;
            platformVersions = [ "37.2" ];
            buildToolsVersions = [ "37.0.0" ];
          };
          homeDir = if pkgs.stdenv.hostPlatform.isDarwin then "/Users/beth" else "/home/beth";
          nssPlatform = if pkgs.stdenv.hostPlatform.isDarwin then "darwin-aarch64" else "linux-x86-64";
        in
        {
          devShells.${system}.default = pkgs.mkShell {
            nativeBuildInputs =
              with pkgs;
              [
                kotlin
                openjdk25
                pkg-config
                python314Packages.gyp
                python314Packages.ninja
                python314Packages.pip
                rust-analyzer
                rustPlatform.bindgenHook
                zlib
              ]
              ++ [
                androidPlatform.androidsdk
                toolchain
              ];

            shellHook = ''
              export ANDROID_HOME="${androidPlatform.androidsdk}/libexec/android-sdk"
              export ANDROID_NDK_ROOT="${androidPlatform.androidsdk}/libexec/android-sdk/ndk-bundle"
              export GLEAN_PYTHON_VENV_DIR="${homeDir}/Workspace/src/github.com/freshstrangemusic/config/environments/application-services/venv"
              export NSS_DIR="${homeDir}/Workspace/src/github.com/mozilla/application-services/libs/desktop/${nssPlatform}/nss"
              export NSS_STATIC=1
            '';
          };
        }
      );
}
