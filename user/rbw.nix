{ pkgs, ... }:

{
  programs.rbw = {
    enable = true;
    settings = {
      email = "jeroen.vanrenterghem@student.hogent.be";
      base_url = "https://sel-opdracht5-jeroen-secrets.groep99.be";
      pinentry = pkgs.pinentry-curses;
    };
  };
}
