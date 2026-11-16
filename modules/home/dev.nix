{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.elliebytes.dev.enable = lib.mkEnableOption "development";

  config = lib.mkIf config.elliebytes.dev.enable {
    home.packages = with pkgs; [
      direnv
      git
      lazygit
      delta
      gh
    ];

    programs.gh = {
      enable = lib.mkDefault true;
      settings = {
        editor = "nvim";
        git_protocol = "ssh";
      };
    };

    programs.git = {
      enable = true;
      extraConfig.credential.helper = "gh";
    };

    programs.lazygit = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };

    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      nix-direnv.enable = true;
    };

    services.ssh-agent.enable = true;
  };
}
