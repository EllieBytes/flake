{ config, lib, pkgs, ... }:

let
  inherit (lib) mkIf;
  cfg = config.profiles.base;
in {
  config = mkIf cfg.enable {
    programs.neovim = {
      enable = lib.mkDefault true;
      defaultEditor = lib.mkDefault true;
      vimAlias = true;
    };

    environment.systemPackages = with pkgs; [
      # Modern Unix.
      bat
      ripgrep
      fd
      glances
      fzf

      # File handling.
      ouch
      unzip
      _7zz
      yazi
      rclone
      erdtree

      # Terminal.
      tmux
      screen

      # Other utils.
      pciutils
      usbutils
      lm_sensors
      smartmontools
      parted
      git
    ];
  };
}
