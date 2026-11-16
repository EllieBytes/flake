{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = lib.mkIf (config.profiles.desktop.enable && config.profiles.desktop.backend == "xfce") {
    services.xserver = {
      enable = true;

      desktopManager.xfce.enable = true;
      desktopManager.xfce.enableXfwm = true;
      desktopManager.xfce.enableWaylandSession = lib.mkDefault true;
      desktopManager.xfce.enableScreensaver = lib.mkDefault true;
    };

    programs.dconf.enable = lib.mkDefault true;

    environment.systemPackages = with pkgs; [
      xfce4-whiskermenu-plugin
      xfce4-pulseaudio-plugin
      xfce4-clipman-plugin
      xfce4-systemload-plugin
      xfce4-netload-plugin
      xfce4-weather-plugin
      xfce4-screenshooter
      xfce4-docklike-plugin
      xfce4-session
    ];
  };
}
