{ config, lib, ... }:

let
  inherit (lib)
    mkOption
    mkIf
    mkEnableOption
    types
    ;
in
{
  imports = [
    ./appearance.nix
    ./plugins.nix
  ];

  options.desktop.cosmic = {
    enable = mkEnableOption "COSMIC Desktop";

    theme.dark = mkOption {
      type = types.path;
      default = ./assets/protest.ron;
    };

    theme.light = mkOption {
      type = types.path;
      default = ./assets/rose-pine-dawn.ron;
    };
  };

  config = mkIf config.desktop.cosmic.enable {
    wayland.desktopManager.cosmic.enable = true;
    programs.cosmic-ext-ctl.enable = lib.mkDefault true;
    programs.cosmic-ext-tweaks.enable = lib.mkDefault true;
  };
}
