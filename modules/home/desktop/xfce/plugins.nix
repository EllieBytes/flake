{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = lib.mkIf config.desktop.xfce.enable {
    home.packages = with pkgs; [
      xfce4-alsa-plugin
      xfce4-cpufreq-plugin
      xfce4-cpugraph-plugin
      xfce4-exo
      xfce4-fsguard-plugin
      xfce4-i3-workspaces-plugin
      xfce4-mailwatch-plugin
      xfce4-netload-plugin
      xfce4-notes-plugin
      xfce4-panel-profiles
    ];
  };
}
