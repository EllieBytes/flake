{
  imports = [
    ./users.nix
  ];

  profiles.base.enable = true;
  profiles.base.bootmode = "lanzaboote";

  profiles.desktop.enable = true;
  profiles.laptop.enable = true;
}
