{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = lib.mkIf config.desktop.cosmic.enable {
    home.packages = with pkgs; [
      cosmic-ext-applet-caffeine
      cosmic-ext-applet-minimon
      cosmic-ext-applet-external-monitor-brightness
      cosmic-ext-applet-weather
      cosmic-ext-applet-privacy-indicator
    ];
  };
}
