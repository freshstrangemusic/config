{
  pkgs ? import <nixpkgs> { },
}:
let
  androidPlatform = pkgs.androidenv.composeAndroidPackages {
    includeNDK = true;
    platformVersions = [ "36.1" ];
    buildToolsVersions = [ "35.0.0" ];
  };
in
pkgs.mkShell {
  buildInputs =
    with pkgs;
    [
      cargo
      clippy
      rust-analyzer
      rustPlatform.bindgenHook
      rustc
      rustfmt

      pkg-config
      python314Packages.gyp
      python314Packages.ninja
      zlib

      openjdk17
      kotlin
    ]
    ++ [ androidPlatform.androidsdk ];

  shellHook = ''
    export ANDROID_HOME="${androidPlatform.androidsdk}/libexec/android-sdk"
    export ANDROID_NDK_ROOT="${androidPlatform.androidsdk}/ndk-bundle"
  '';
}
