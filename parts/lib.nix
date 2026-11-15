{ config, lib, inputs, ... }:

{
  flake.lib = import ../lib { inherit lib inputs; inherit (config) flake; };
}
