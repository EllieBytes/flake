{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = lib.mkIf (config.profiles.desktop.enable && config.profiles.desktop.backend == "cosmic") {
    services.desktopManager.cosmic = {
      enable = true;
      xwayland.enable = true;
    };

    services.displayManager.sddm.enable = lib.mkOverride 900 false;

    services.displayManager.cosmic-greeter.enable = true;

    environment.cosmic.excludePackages = with pkgs; [
      cosmic-player
    ];

    environment.systemPackages = with pkgs; [
      cosmic-ext-applet-privacy-indicator
      cosmic-ext-applet-caffeine
      cosmic-ext-applet-sysinfo
      cosmic-ext-applet-minimon
      cosmic-ext-applet-external-monitor-brightness
      cosmic-ext-ctl
      cosmic-ext-tweaks
      cosmic-ext-applet-weather
    ];
  };
}
