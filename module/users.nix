{ lib, config, pkgs, ... }:

let
  cfg = config.users;
in
{
  options.users = {
    enable = lib.mkEnableOption "enable users module";

    userName = lib.mkOption {
      default = "user";
      description = "@username";
    };
  };

  config = lib.mkIf cfg.enable {
    users.users = builtins.listToAttrs (map (user: {
        name = user.name;
        value = {
          isNormalUser = true;
          initialPassword = "";
          description = user.description;
          shell = user.shell or pkgs.fish;
          # By default, no one have SUDO access.
          extraGroups = user.extraGroups or [];
        };
      }) cfg.users);
  };
}

