{ config, lib, ... }:

let
  inherit (lib) mkDefault;
in
{
  config = lib.mkIf config.profiles.base.enable {
    nix = {
      settings = {
        auto-optimize-store = true;
        extra-experimental-features = [
          "nix-command"
          "flakes"
          "pipe-operators"
        ];

        trusted-users = [
          "root"
          "@wheel"
        ];

        substituters = [
          "https://nix-mirror.freetls.fastly.net"
        ];
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
