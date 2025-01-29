{ lib, config, pkgs, ... }:

let
  cfg = config.users;
in
{
  options.users = {
    enable = lib.mkEnableOption "enable users module";

    userList = lib.mkOption {
      default = [];
      description = "@username";
    };
  };

  config = lib.mkIf cfg.enable {
    users.users = builtins.listToAttrs (map (user: {
        name = user.name;
        value = {
          isNormalUser = user.isNormalUser or true;
	  # By default, no password! Do not forget to use `passwd`.
          initialPassword = null;
          description = user.description or null;
          shell = user.shell or pkgs.fish;
          # By default, no one have SUDO access.
          extraGroups = user.extraGroups or [];
        };
      }) cfg.userList);
  };
}

