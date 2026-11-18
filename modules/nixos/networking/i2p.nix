{
  config,
  lib,
  ...
}:

let
  inherit (lib)
    mkEnableOption
    mkOption
    types
    mkIf
    ;

  inherit (types) enum;
  cfg = config.elliebytes.net.i2p;

  isMode = mode: cfg.mode == mode;
in
{
  options.elliebytes.net.i2p = {
    enable = mkEnableOption "I2P services";

    mode = mkOption {
      type = enum [
        "client"
        "server"
      ];

      default = "client";
    };
  };

  config = mkIf cfg.enable {
    services.i2pd = {
      enable = true;
      enableIPv6 = true;
      address = lib.mkDefault (if isMode "client" then "127.0.0.1" else "0.0.0.0");
      notransit = lib.mkDefault (isMode "client");

      proto = {
        httpProxy = {
          port = 4444;
          enable = true;
        };

        socksProxy = {
          port = 4447;
          enable = true;
        };
      };
    };
  };
}
