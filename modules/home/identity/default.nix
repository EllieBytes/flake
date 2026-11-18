{
  lib,
  ...
}:

let
  inherit (lib) mkOption types;
in
{
  imports = [
    ./git.nix
  ];

  options.identity = {
    name = mkOption {
      type = types.str;
      default = "Nobody";
      example = "Ellie Johnston";
      description = "Your name";
    };

    email = mkOption {
      type = types.str;
      default = "";
      example = "jellie7118@proton.me";
      description = "Your email address";
    };
  };
}
