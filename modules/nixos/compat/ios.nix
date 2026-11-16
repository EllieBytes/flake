{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkOption types mkIf;
in
{
  options.elliebytes.compat.ios = {
    enable = lib.mkEnableOption "IOS compatibility";
  };

  config = mkIf config.elliebytes.compat.ios.enable {
    services.usbmuxd.enable = lib.mkDefault true;
    services.usbmuxd.package = pkgs.usbmuxd2;

    environment.systemPackages = with pkgs; [
      libimobiledevice
      ifuse
    ];
  };
}
