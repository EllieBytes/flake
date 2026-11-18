{ config, lib, ... }:

let
  inherit (lib)
    mkIf
    mkEnableOption
    mkOption
    types
    ;
in
{
  options.desktop.xfce = {
    enable = mkEnableOption "XFCE Desktop Setup";
  };

  config = mkIf config.desktop.xfce.enable {

  };
}
