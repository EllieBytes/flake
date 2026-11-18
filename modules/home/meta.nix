{ inputs, ... }:

{
  namespace = "homeModules";

  extraModules = [
    inputs.zen-browser.homeModules.default
    inputs.cosmic-manager.homeManagerModules.default
  ];
}
