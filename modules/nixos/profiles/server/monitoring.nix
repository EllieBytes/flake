{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkOption mkIf types;
  inherit (types) listOf enum;

  hasMonitor = mon: builtins.elem mon config.profiles.server.monitoring.monitors;
in
{
  options.profiles.server = {
    lanAddress = mkOption {
      type = types.str;
    };

    monitoring = {
      enable = mkOption {
        type = types.bool;
        default = true;
        example = false;
        description = ''
          Whether to enable monitoring services.
        '';
      };

      monitors = mkOption {
        type = listOf (enum [
          "cockpit"
          "prometheus"
        ]);

        default = [ "cockpit" ];
      };
    };
  };

  config = mkIf config.profiles.server.enable {
    services.cockpit = mkIf (hasMonitor "cockpit") {
      enable = lib.mkDefault true;
      port = 9090;
      openFirewall = true;
      plugins = with pkgs; [
        cockpit-files
        cockpit-podman
        cockpit-machines
      ];
    };

    services.prometheus = mkIf (hasMonitor "prometheus") {
      exporters.node = {
        enable = lib.mkDefault true;
        port = lib.mkDefault 9100;
        enabledCollectors = lib.mkDefault [
          "systemd"
          "ethtool"
          "softirqs"
          "tcpstat"
          "wifi"
        ];

        extraFlags = [
          "--collector.ntp.protocol-version=4"
          "--no-collector.mdadm"
        ];
      };
    };
  };
}
