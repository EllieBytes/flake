{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkDefault;
  cfg = config.profiles.desktop;
in
{
  imports = [ ];

  config = lib.mkIf (cfg.enable && (cfg.backend == "swayfx")) {
    programs.sway = {
      enable = mkDefault true;
      package = pkgs.swayfx;
      xwayland.enable = mkDefault true;
      wrapperFeatures.gtk = true;
      extraPackages = with pkgs; [
        nwg-displays
        wofi
        swaylock-effects
        (pkgs.writeShellScriptBin "swayfx-lock" (builtins.readFile ./static/swayfx-lock))
        waybar
        grim
        slurp
      ];
    };

    environment.etc."sway/config".source = ./static/swayfx.conf;

    security.pam.services.swaylock = { };
  };
}
