{ config, lib, ... }:

{
  imports = [
    ./base
    ./desktop
    ./server
  ];

  profiles.base.enable = lib.mkDefault true;
}
