{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    mkIf
    mkOverride
    mkForce
    mkDefault
    ;

  cfg = config.profiles.base;
in
{
  config = mkIf (cfg.enable && (cfg.bootmode == "lanzaboote")) {
    environment.systemPackages = [ pkgs.sbtcl ];

    boot.lanzaboote = {
      enable = mkOverride 900 true;
      pkiBundle = mkDefault "/var/lib/sbctl";
    };

    boot.loader = {
      systemd-boot.enable = mkForce false;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = mkDefault cfg.inferredESP;
    };
  };
}
