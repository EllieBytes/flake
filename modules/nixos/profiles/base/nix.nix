{ config, lib, ... }:

let
  inherit (lib) mkDefault;
in
{
  config = lib.mkIf config.profiles.base.enable {
    nix = {
      settings = {
        extra-experimental-features = [
          "nix-command"
          "flakes"
          "pipe-operators"
        ];
        trusted-users = [
          "root"
          "@wheel"
        ];
        auto-optimize-store = true;
      };

      gc = {
        automatic = mkDefault true;
        persistent = mkDefault true;
        options = mkDefault "--delete-older-than=14d";
        dates = mkDefault "weekly";
        randomizedDelaySec = mkDefault "1h";
      };
    };
  };
}
