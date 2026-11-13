{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.profiles.server.enable {
    services.cockpit = {
      enable = lib.mkDefault true;
      port = 9090;
      openFirewall = true;
      plugins = with pkgs; [
        cockpit-files
        cockpit-podman
        cockpit-machines
      ];
    };
  };
}
