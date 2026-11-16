{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = lib.mkIf config.elliebytes.desktop.swayfx.enable {
    programs.waybar = {
      enable = true;
      package = pkgs.waybar;
      settings = builtins.fromJSON (builtins.readFile ./assets/waybar.json);
      style = ./assets/waybar.css;
      systemd.enable = true;
    };

    home.packages = with pkgs; [
      waybar-mpris
      waybar-lyric
    ];
  };
}
