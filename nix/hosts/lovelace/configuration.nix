{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  common = (import ../../common.nix) {
    inherit inputs pkgs;
    system = "aarch64-darwin";
  };
in
{
  imports = [ ./wsl.nix ];

  environment.systemPackages =
    with pkgs;
    common.systemPackages
    ++ [
      nodejs_23
      python313
    ];

  programs.fish.enable = true;
  programs.nix-ld.enable = true;
  programs.vim = {
    enable = true;
    defaultEditor = true;
  };

  networking.hostName = "lovelace";

  services.envfs.enable = true;

  users.groups.beth = { };
  users.users.beth = {
    isNormalUser = true;
    description = "beth";
    extraGroups = [
      "beth"
      "users"
      "wheel"
    ];
    shell = pkgs.fish;
  };

  system.stateVersion = "24.11";
}
