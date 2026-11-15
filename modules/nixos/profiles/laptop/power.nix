{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    mkOption
    types
    mkIf
    mkDefault
    ;
  inherit (types) enum;

  cfg = config.profiles.laptop;
in
{
  options.profiles.laptop = {
    powerManagementStrategy = mkOption {
      type = enum [
        "tlp"
        "power-profiles-daemon"
        "auto-cpufreq"
        "none"
      ];

      default = "power-profiles-daemon";
    };
  };

  config = mkIf cfg.enable {
    powerManagement.enable = mkDefault (cfg.powerManagementStrategy != "none");
    powerManagement.powertop.enable = mkDefault (cfg.powerManagementStrategy != "none");
    services.thermald.enable = mkDefault true;

    services.power-profiles-daemon.enable = cfg.powerManagementStrategy == "power-profiles-daemon";

    services.tlp = mkIf (cfg.powerManagementStrategy == "tlp") {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        START_CHARGE_THRESH_BAT0 = 75;
        STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };

    services.auto-cpufreq = mkIf (cfg.powerManagementStrategy == "auto-cpufreq") {
      enable = true;
      settings = {
        on-battery = {
          governor = "powersave";
          turbo = "never";
        };

        on-ac = {
          governor = "performance";
          turbo = "auto";
        };
      };
    };
  };
}
