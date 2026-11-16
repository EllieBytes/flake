{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    nix-output-monitor
    nh
    nix-index
    nix-tree
    gnupg
    caddy
    ast-grep
  ];

  programs.tealdeer = {
    enable = lib.mkDefault true;
    enableAutoUpdates = true;
    settings = {
      display = {
        compact = false;
        use_pager = true;
      };
    };
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };
}
