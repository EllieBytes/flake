{ config, lib, ... }:

{
  imports = [
    ./shell.nix
    ./utils.nix
    ./nix.nix
    ./security.nix
    ./boot
  ];

  options.profiles.base = {
    enable = lib.mkEnableOption "the `base` profile";
  };
}
