{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = lib.mkIf config.profiles.base.enable {
    security.apparmor.enable = lib.mkDefault true;
    security.apparmor.enableCache = lib.mkDefault true;
    security.apparmor.packages = [ pkgs.apparmor-profiles ];

    nix-mineral = {
      enable = lib.mkDefault true;
      preset = lib.mkDefault [
        "compatibility"
        "performance"
      ];
    };
  };
}
