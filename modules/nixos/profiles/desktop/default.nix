{ lib, ... }:

let
  inherit (lib) mkOption types mkEnableOption;
  inherit (types) enum;
in
{
  imports = [
    ./common

    ./swayfx
    ./kde
    ./xfce

    ./users.nix
    ./gaming.nix
  ];

  options.profiles.desktop = {
    enable = mkEnableOption "Profile for desktops";

    gaming = {
      enable = mkEnableOption "Gaming services";
    };

    backend = mkOption {
      type = enum [
        "swayfx"
        "kde"
        "xfce"
      ];

      default = "xfce";
    };
  };
}
