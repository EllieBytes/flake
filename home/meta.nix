{ outputs, ... }:

{
  extraModules = [
    outputs.homeModules.default
  ];
}
