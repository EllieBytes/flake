{ config, lib, ... }:

{
  options.profiles.container = {
    enable = lib.mkEnableOption "the container profile.";
  };

  config = lib.mkIf config.profiles.container.enable {
    profiles.base.enable = lib.mkDefault false; # We have our own, smaller one here.
  };
}
