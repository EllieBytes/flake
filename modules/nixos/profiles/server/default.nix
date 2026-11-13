{ config, lib, pkgs, ... }:


let
  inherit (lib) mkDefault mkEnableOption mkIf;
in
{
  imports = [
    ./ssh.nix
    ./monitoring.nix
    ./nix.nix
    ./security.nix
  ];

  options.profiles.server = {
    enable = mkEnableOption "the server profile";
    enableAutoUpgrades = mkEnableOption "automatic nightly upgrades";
  };

  config = mkIf config.profiles.server.enable {
    system.autoUpgrade = mkIf config.profiles.server.enableAutoUpgrades {
      enable = true;
      dates = mkDefault "3:00";
      randomizedDelaySec = mkDefault "45min";
    };

    services.logind = {
      lidSwitch = "ignore";
      lidSwitchExternalPower = "ignore";
    };

    powerManagement.cpuFreqGovernor = mkDefault "performance";

    environment.systemPackages = with pkgs; [
      dnsutils
      tcpdump
      ethtool
      smartmontools
    ];
  };
}
