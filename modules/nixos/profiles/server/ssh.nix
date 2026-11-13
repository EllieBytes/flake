{ config, lib, ... }:

{
  config = lib.mkIf config.profiles.server.enable {
    services.openssh = {
      enable = lib.mkDefault true;
      openFirewall = config.services.openssh.enable;
      settings = {
        PasswordAuthentication = true;
        PermitRootLogin = "prohibit-password";
      };
    };
  };
}
