{
  inputs,
  burrow,
  config,
  lib,
  ...
}:

let
  inherit (burrow.lib.fs) allPresent intoPaths;
in
{
  burrow.builders.home.buildFunctions.asModule = { meta, path, ... }: {
    homeModules."user-${meta.name}" = {
      imports = [
        ({ lib, ... }: {
          home.username = lib.mkDefault meta.username;
          home.homeDirectory = lib.mkDefault meta.homeDirectory;
        })

        (if builtins.pathExists (path + "/home.nix") then path + "/home.nix" else { })
      ]
      ++ (intoPaths (allPresent meta.files path) path)
      ++ meta.extraModules;
    };
  };
}
