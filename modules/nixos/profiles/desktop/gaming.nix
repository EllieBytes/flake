{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.profiles.desktop.enable && config.profiles.desktop.gaming.enable) {
    assertions = [
      { assertion = config.nixpkgs.config.allowUnfree; message = "You must allow unfree packages for steam to work."; }
    ];

    nixpkgs.config.allowUnfree = lib.mkDefault true;

    programs.steam = {
      enable = lib.mkDefault true;
      protontricks.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localGameTransfers.openFirewall = true;
    };
  };
}
