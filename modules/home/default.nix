{
  imports = [
    ./starship.nix
    ./core.nix
    ./dev.nix
  ];

  home.sessionVariables.DO_NOT_TRACK = "1";
}
