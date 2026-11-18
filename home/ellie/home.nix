{ pkgs, ... }:

{
  home.username = "ellie";
  home.homeDirectory = "/home/ellie";
  nixpkgs.config.allowUnfree = true;

  elliebytes.dev.enable = true;
  desktop.cosmic.enable = true;

  identity.name = "Ellie Johnston";
  identity.email = "jellie7118@proton.me";

  programs.fish.enable = true;

  home.packages = with pkgs; [
    vesktop
    freecad
    kicad
    obsidian
    libreoffice
    onlyoffice-desktopeditors
    archipelago

    yaziPlugins.gvfs
  ];

  home.file.".face".source = ./assets/face.png;

  home.stateVersion = "26.05";
}
