{ lib, config, pkgs, ... }:

let
  cfg = config.users;
in
{
  options.users = {
    userList = lib.mkOption {
      type = lib.types.listOf (lib.types.submodule {
        options = {
          name = lib.mkOption {
            type = lib.types.str;
            description = "The user name.";
          };

          description = lib.mkOption {
            type = lib.types.str;
            default = "No description.";
            description = "User description.";
          };

          shell = lib.mkOption {
            type = lib.types.package;
            default = pkgs.fish;
            description = "User default shell.";
          };

          # By default, no one have SUDO access.
          extraGroups = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [ ];
            description = "Extra groups the user belongs to.";
          };

          isNormalUser = lib.mkOption {
            type = lib.types.bool;
            default = true;
            description = "Whether the user is a normal user.";
          };

          # By default, no password! Do not forget to use `passwd`.
          initialPassword = lib.mkOption {
            type = lib.types.str;
            default = "";
            description = "User default password.";
          };
        };
      });

      default = [ ];
      description = "Declare users lists.";
    };
  };

  config = {
    users.users = builtins.listToAttrs (
      map
        (user: {
          name = user.name;
          value = {
            description = user.description;
            shell = user.shell;
            isNormalUser = user.isNormalUser;
            extraGroups = user.extraGroups;
            initialPassword = "";
          };
        })
        cfg.userList
    );

    home-manager.users = builtins.listToAttrs (
      map
        (user: {
          name = user.name;
          value = import "../../../home_manager/user/" +
            "${user.name}/${user.name}.nix";
        })
        cfg.userList
    );
  };
}

