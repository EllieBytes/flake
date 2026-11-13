{ config, lib, ... }:

let
  inherit (lib) mkIf mkOverride mkDefault;
  cfg = config.profiles.base;
in
{
  config = lib.mkIf (cfg.enable && (cfg.bootmode == "uefi")) {
    boot.loader = {
      systemd-boot.enable = mkOverride 900 true;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = mkDefault cfg.inferredESP;
    };
  };
}
