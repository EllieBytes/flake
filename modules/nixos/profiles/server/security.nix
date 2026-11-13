{ config, lib, ... }:

{
  config = lib.mkIf config.profiles.server.enable {
    services.fail2ban.enable = lib.mkDefault true;
  };
}
