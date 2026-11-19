{
  pkgs ? import <nixpkgs> { },
}:
let
  androidPlatform = pkgs.androidenv.composeAndroidPackages {
    includeNDK = true;
    platformVersions = [ "36.1" ];
    buildToolsVersions = [ "36.0.0" ];
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
      python314Packages.pip
      python314Packages.gyp
      python314Packages.ninja
      zlib

      openjdk25
      kotlin
    ]
    ++ [ androidPlatform.androidsdk ];

  shellHook = ''
    export ANDROID_HOME="${androidPlatform.androidsdk}/libexec/android-sdk"
    export ANDROID_NDK_ROOT="${androidPlatform.androidsdk}/libexec/android-sdk/ndk-bundle"
    export GLEAN_PYTHON_VENV_DIR="/home/beth/Workspace/src/github.com/freshstrangemusic/config/environments/application-services/venv"
    export NSS_DIR="/home/beth/Workspace/src/github.com/mozilla/application-services/libs/desktop/linux-x86-64/nss"
    export NSS_STATIC=1
  '';
}
