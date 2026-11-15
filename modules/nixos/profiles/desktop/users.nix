{ config, lib, ... }:

{
  config = lib.mkIf config.profiles.desktop.enable {
    user.roles.desktop-user = {
      groups = [
        "audio"
        "video"
        "input"
        "networkmanager"
      ];
    };

    user.commonRoles = [ "desktop-user" ];
  };
}
