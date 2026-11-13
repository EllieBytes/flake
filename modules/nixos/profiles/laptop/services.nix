{ config, lib, ... }:

{
  options.profiles.laptop = {
    locationServices = lib.mkEnableOption "location services";
  };

  config = mkIf config.profiles.laptop.enable {
    profiles.laptop.locationServices = lib.mkDefault true;

    location.provider = (if config.profiles.laptop.locationServices then "geoclue2" else "manual");
  };
}
