{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./sway.nix
    ./keybinds.nix
    ./fx.nix
    ./startup.nix

    ./waybar.nix
    ./swaync.nix
    ./mako.nix
    ./vicinae.nix
  ];

  options.elliebytes.desktop.sway = {
    enable = lib.mkEnableOption "SwayFX desktop";
  };

}
