{ lib, config, pkgs, ... }:

let
  cfg = config.users;
in
{
  options.users = {
    userList = lib.mkOption {
      type = lib.types.listOf lib.types.str;
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
        (
          user: {
            name = user.name;
            value = {
              isNormalUser = user.isNormalUser or true;
              # By default, no password! Do not forget to use `passwd`.
              initialPassword = "";
              description = user.description or "no description";
              shell = user.shell or pkgs.fish;
              # By default, no one have SUDO access.
              extraGroups = user.extraGroups or [ ];
            };
          }
        )
        cfg.userList
    );

    home-manager.users = builtins.listToAttrs (
      map
        (
          user: {
            name = user.name;
            value = import "../../../home_manager/user/${user.name}/${user.name}.nix";
          }
        )
        cfg.userList
    );
  };
}

