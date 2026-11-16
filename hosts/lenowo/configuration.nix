{
  imports = [
    ./users.nix
    ./disk.nix
    ./hardware.nix
  ];

  nixpkgs.config.allowUnfree = true;

  profiles.base.enable = true;
  profiles.base.bootmode = "lanzaboote";

  profiles.desktop.enable = true;
  profiles.desktop.backend = "xfce";

  profiles.laptop.enable = true;

  system.stateVersion = "26.05";
}
