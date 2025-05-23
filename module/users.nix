{ lib, config, pkgs, ... }:

let
  cfg = config.users;
in
{
  options.users = {
    enable = lib.mkEnableOption "Enable users module.";

    userList = lib.mkOption {
      default = [];
      description = "Declare users lists.";
    };
  };

  config = lib.mkIf cfg.enable {
    users.users = builtins.listToAttrs (map (user: {
        name = user.name;
        value = {
          isNormalUser = user.isNormalUser or true;
	  # By default, no password! Do not forget to use `passwd`.
          initialPassword = "";
          description = user.description or "no description";
          shell = user.shell or pkgs.fish;
          # By default, no one have SUDO access.
          extraGroups = user.extraGroups or [];
        };
      }) cfg.userList);
  };
}

