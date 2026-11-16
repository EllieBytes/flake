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

  elliebytes = {
    compat.ios.enable = true;
    net.i2p.enable = true;
    net.i2p.mode = "client";
  };

  system.stateVersion = "26.05";
}
