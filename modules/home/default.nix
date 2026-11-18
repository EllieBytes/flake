{
  imports = [
    ./starship.nix
    ./core.nix
    ./dev.nix

    ./identity
    ./desktop
  ];

  home.sessionVariables.DO_NOT_TRACK = "1";
}
