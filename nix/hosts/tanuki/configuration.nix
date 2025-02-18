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
      "users"
      "wheel"
    ];
  };

  environment.systemPackages = with pkgs; [
    git
    jujutsu
    just
    nixfmt-rfc-style
    stow
    vim
    wget
  ];

  programs.nix-ld.enable = true;

  services.envfs.enable = true;
  services.openssh.enable = true;
  services.openssh.settings = {
    PermitRootLogin = "no";
    PasswordAuthentication = false;
  };
  services.samba.enable = true;
  services.samba.nmbd.enable = true;
  services.samba.openFirewall = true;

  system.stateVersion = "24.11";
}
