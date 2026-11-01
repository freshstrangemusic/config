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
  ];
  
  fonts.packages = with pkgs; [
    fira-code
  ];

  programs._1password.enable = true;
}
