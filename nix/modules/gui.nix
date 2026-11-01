# Common configuration for all hosts with a GUI.

{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    alacritty
    fira-code
    neovide
    nerd-fonts.fira-code
  ];
  
  fonts.packages = with pkgs; [
    fira-code
    nerd-fonts.fira-code
  ];

  programs._1password.enable = true;
}
