{ config, lib, ... }:

{
  config = lib.mkIf config.profiles.base.enable {
    networking = {
      networkmanager.enable = lib.mkDefault true;
      nftables.enable = lib.mkDefault true;

      firewall = {
        backend = "nftables";
        allowedTCPPorts = [ ];
        allowedUDPPorts = [ ];
      };

      nameservers = [
        "1.1.1.1"
        "1.0.0.1"
        "8.8.8.8"
      ];
    };
  };
}
