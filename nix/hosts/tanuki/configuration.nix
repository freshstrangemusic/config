{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 10;
  };

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
    shell = pkgs.fish;
  };

  environment.etc."ssh/authorized_keys.d/beth" = {
    text = ''
      ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKZeV/on0OSe3hAyDKsPzQ1fblhlH47MhxiEN0zfgWzI
    '';
    mode = "0644";
  };
  environment.systemPackages = with pkgs; [
    docker
    pam_rssh
  ];

  programs._1password.enable = true;
  programs.fish.enable = true;
  programs.nix-ld.enable = true;

  security.pam.rssh.enable = true;
  security.pam.services.sudo.rssh = true;

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
