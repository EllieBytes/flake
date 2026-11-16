{
  config,
  lib,
  ...
}:

{
  config = lib.mkIf config.profiles.base.enable {
    boot = {
      consoleLogLevel = 3;
      initrd.systemd.enable = true;
      initrd.verbose = lib.mkDefault false;

      plymouth = {
        enable = lib.mkDefault true;
        theme = lib.mkDefault "bgrt";
      };
    };
  };
}
