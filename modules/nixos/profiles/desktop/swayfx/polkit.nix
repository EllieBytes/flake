{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = lib.mkIf (config.profiles.desktop.enable && config.profiles.desktop.backend == "swayfx") {
    systemd.user.services.polkit-kde-authentication-agent-1 = {
      description = "polkit-kde-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
