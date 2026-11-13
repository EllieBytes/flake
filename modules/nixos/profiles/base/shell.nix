{ config, lib, pkgs, ... }:

let
  inherit (lib) mkIf mkDefault;
  cfg = config.profiles.base;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      eza
    ];

    users.defaultUserShell = mkDefault pkgs.fish;

    programs.fish = {
      enable = mkDefault true;
      package = mkDefault pkgs.fish;

      shellAliases = mkDefault {
        "ls" = "${pkgs.eza}/bin/eza --color=auto --icon=auto";
      };
    };
  };
}
