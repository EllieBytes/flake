{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.profiles.desktop.enable {
    services.printing.enable = true;
    services.upower.enable = true;
    services.libinput.enable = true;
    services.udisks2.enable = lib.mkDefault true;
    services.udisks2.mountOnMedia = lib.mkDefault true;

    networking.networkmanager.enable = lib.mkDefault true;

    hardware.bluetooth.enable = lib.mkDefault true;
    hardware.bluetooth.powerOnBoot = lib.mkDefault true;

    environment.systemPackages = with pkgs; [
      libnotify
      blueman
      bluetuith
    ];
  };
}
