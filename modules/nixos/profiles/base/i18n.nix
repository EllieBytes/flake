{ config, lib, ... }:

{
  config = lib.mkIf config.profiles.base.enable {
    time.timeZone = lib.mkDefault "America/New_York";
    environment.sessionVariables.TZ = config.time.timeZone;

    i18n.defaultLocale = "en_US.UTF-8";
  };
}
