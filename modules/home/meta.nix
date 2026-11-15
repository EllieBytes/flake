{ inputs, ... }:

{
  namespace = "homeModules";

  extraModules = [
    inputs.zen-browser.homeModules.default
  ];
}
