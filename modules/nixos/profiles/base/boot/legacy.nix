{ config, lib, ... }:

let
  inherit (lib) mkIf mkOverride mkDefault;
  cfg = config.profiles.base;
in
{
  config = mkIf (cfg.enable && (cfg.bootmode == "legacy")) {
    boot.loader.grub = {
      enable = mkOverride 900 true;
      device = mkDefault "nodev";
      useOSProber = mkDefault true;
    };
  };
}
