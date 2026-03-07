{ pkgs, ... }:

{
  home.packages = with pkgs; [
    xdotool
  ];
}
