{
  config,
  lib,
  cosmicLib,
  ...
}:

let
  inherit (lib) mkIf;
  inherit (cosmicLib.cosmic) importRON;
  cfg = config.desktop.cosmic;
in
{
  config = mkIf cfg.enable {
    wayland.desktopManager.cosmic.appearance = {
      theme = {
        mode = lib.mkDefault "dark";
        dark = importRON cfg.theme.dark;
        # light = importRON cfg.theme.light;
      };
    };
  };
}
