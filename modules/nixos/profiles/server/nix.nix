{ config, lib, ... }:

{
  config = lib.mkIf config.profiles.server.enable {
    nix.gc.options = lib.mkOverride 900 "--delete-older-than=30d";
  };
}
