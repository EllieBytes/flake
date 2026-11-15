{ config, lib, ... }:

{
  imports = [
    ./power.nix
    ./hardware.nix
    ./services.nix
  ];

  options.profiles.laptop = {
    enable = lib.mkEnableOption "Laptop profile";
  };

  config = lib.mkIf config.profiles.laptop.enable {
    profiles.desktop.enable = lib.mkDefault true;
  };
}
