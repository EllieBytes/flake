{ config, lib, ... }:

{
  config = lib.mkIf config.programs.git.enable {
    programs.git.settings.user.name = lib.mkDefault config.identity.name;
    programs.git.settings.user.email = lib.mkDefault config.identity.email;
  };
}
