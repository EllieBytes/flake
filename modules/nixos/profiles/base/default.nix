{ lib, ... }:

{
  imports = [
    ./shell.nix
    ./utils.nix
    ./users.nix
    ./nix.nix
    ./security.nix
    ./i18n.nix
    ./networking.nix
    ./hardware.nix

    ./boot
  ];

  options.profiles.base = {
    enable = lib.mkEnableOption "the `base` profile";
  };
}
