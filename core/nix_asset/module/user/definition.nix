{ lib, config, pkgs, ... }:

let
  userToAdd = config.user.userToAdd;
  definedUser = config.user.userList;

  /**
    Filters a list of user definitions to include.

    Parameters
    ----------
    userToAdd : `lib.types.listOf lib.types.str`
        A list of user names that should be retained for a given host.

    definedUser : `lib.types.listOf lib.types.setType`
        A list of defined user attribute in a set.

    Returns
    -------
    `lib.types.listOf lib.types.setType`
        A filtered list of user to include.
  */
  filteredUserToAdd = builtins.filter (definedUserItem: builtins.elem definedUserItem.name userToAdd) definedUser;

  /**
    Extract user names from the `definedUser` list.

    Parameters
    ----------
    definedUser : `lib.types.listOf lib.types.setType`
        A list of defined user attribute in a set.

    Returns
    -------
    `lib.types.listOf lib.types.str`
        A list of defined user names.
  */
  userName = map (definedUserItem: definedUserItem.name) definedUser;

  /**
    Filters a list of user definitions to check which are asked to be included, but
    actually are not existing.

    Parameters
    ----------
    userName : `lib.types.listOf lib.types.str`
        A list of defined user names.

    userToAdd : `lib.types.listOf lib.types.str`
        A list of user names that should be retained for a given host.

    Returns
    -------
    `lib.types.listOf lib.types.str`
        A filtered list of user that are undefined.
  */
  undefinedUser = builtins.filter (userToAddItem: !builtins.elem userToAddItem userName) userToAdd;

  /**
    Format the error form the `undefinedUser` list.

    Parameters
    ----------
    underfinedUser : `lib.types.listOf lib.types.str`
        A filtered list of user that are undefined.

    Returns
    -------
    `lib.types.str`
        The error message to display if the `underfinedUser` list is not empty.
  */
  undefinedUserError = builtins.concatStringsSep "" [
    "[Err##] The following users in `user.userToAdd` do not exist in "
    "`user.userList`:\n - "
    (builtins.concatStringsSep "\n  - " undefinedUser)
  ];

  /**
    Throw an error when a user is asked to be added for a host, but is not definied
    in `definedUser`.
  */
  _ = assert (builtins.length undefinedUser == 0) || throw undefinedUserError; null;
in
{
  options.user = {
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
      description = "Declare global users lists.";
    };

    userToAdd = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Declare users to add to a host.";
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
        filteredUserToAdd
    );

    home-manager.users = builtins.listToAttrs (
      map
        (user: {
          name = user.name;
          value = import "../../../home_manager/user/" +
            "${user.name}/${user.name}.nix";
        })
        filteredUserToAdd
    );
  };
}
