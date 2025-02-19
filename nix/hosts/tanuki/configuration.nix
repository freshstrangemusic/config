{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "tanuki";

  i18n.defaultLocale = "en_CA.UTF-8";
  time.timeZone = "America/Toronto";

  users.groups.beth = { };
  users.users.beth = {
    isNormalUser = true;
    extraGroups = [
      "beth"
      "docker"
      "users"
      "wheel"
    ];
  };

  environment.systemPackages = with pkgs; [
    docker
    git
    jujutsu
    just
    nixfmt-rfc-style
    ripgrep
    stow
    vim
    wget
  ];

  programs.nix-ld.enable = true;
  programs.vim = {
    enable = true;
    defaultEditor = true;
  };

  services.envfs.enable = true;
  services.openssh.enable = true;
  services.openssh.settings = {
    PermitRootLogin = "no";
    PasswordAuthentication = false;
  };
  services.samba.enable = true;
  services.samba.nmbd.enable = true;
  services.samba.openFirewall = true;

  virtualisation.docker.enable = true;

  system.stateVersion = "24.11";
}
