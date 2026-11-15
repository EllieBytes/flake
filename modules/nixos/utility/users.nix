{ config, lib, ... }:

let
  cfg = config.user;
  inherit (builtins)
    attrValues
    concatLists
    elem
    ;

  inherit (lib)
    mkOption
    types
    mapAttrs'
    mkOverride
    mkBefore
    filterAttrs
    mapAttrsToList
    concatMap
    unique
    ;

  inherit (types) listOf attrsOf submodule;
in
{
  options = {
    user = {
      roles = mkOption {
        type = attrsOf (
          submodule (
            { name, ... }: {
              options = {
                name = mkOption {
                  type = types.str;
                  default = name;
                };

                groups = mkOption {
                  type = listOf types.str;
                  default = [ ];
                };

                revokeGroups = mkOption {
                  type = listOf types.str;
                  default = [ ];
                  description = ''
                    Groups to revoke from this user
                  '';
                };

                packages = mkOption {
                  type = listOf types.package;
                  default = [ ];
                };

                sudoRules = mkOption {
                  type = listOf types.attrs;
                  default = [ ];
                };

                assignees = mkOption {
                  type = listOf types.str;
                  default = [ ];
                  description = ''
                    Users to assign this role to.
                  '';
                };
              };
            }
          )
        );

        default = { };
      };

      commonRoles = mkOption {
        type = listOf types.str;
        default = [ ];
        description = ''
          Roles to assign to all (normal) users.
        '';
      };
    };

    users.users = mkOption {
      type = attrsOf (
        submodule (
          { name, config, ... }:
          let
            userRoles = attrValues (
              filterAttrs (
                _: role: elem name role.assignees || (config.isNormalUser && elem role.name cfg.commonRoles)
              ) cfg.roles
            );

            revoked = unique (concatMap (role: role.revokeGroups) userRoles);
            granted = unique (concatMap (role: role.groups) userRoles) ++ config.groups;
          in
          {
            options.groups = mkOption {
              type = listOf types.str;
              default = [ ];
              description = ''
                Groups to grant this user before RBAC.
              '';
            };

            config = {
              packages = mkBefore (concatMap (r: r.packages) userRoles);
              extraGroups = mkOverride 90 (
                concatMap (r: (lib.subtractLists revoked granted) ++ [ "role-${r.name}" ]) userRoles
              );
            };
          }
        )
      );
    };
  };

  config = {
    users.groups = mapAttrs' (name: _: {
      name = "role-${name}";
      value = { };
    }) cfg.roles;

    security.sudo.extraRules = concatLists (
      mapAttrsToList (
        name: roleCfg: map (rule: rule // { groups = [ "role-${name}" ]; }) roleCfg.sudoRules
      ) cfg.roles
    );
  };
}
