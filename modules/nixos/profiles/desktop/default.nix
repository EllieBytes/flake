{ config, lib, ... }:

let
  inherit (lib) mkOption types mkEnableOption;
  inherit (types) enum;
in
{
  imports = [
    ./common
    ./swayfx

    ./gaming.nix
  ];

  options.profiles.desktop = {
    enable = mkEnableOption "Profile for desktops";

    gaming = {
      enable = mkEnableOption "Gaming services";
    };

    backend = mkOption {
      type = enum [ "swayfx" /* "xfce" "cosmic" */ ];
      default = "swayfx";
    };
  };
}
