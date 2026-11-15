{ config, lib, ... }:

{
  config = lib.mkIf config.profiles.base.enable {
    security.apparmor.enable = lib.mkDefault true;
    security.apparmor.enableCache = lib.mkDefault true;

    nix-mineral = {
      enable = lib.mkDefault true;
      preset = lib.mkDefault [
        "compatibility"
        "performance"
      ];
    };
  };
}
