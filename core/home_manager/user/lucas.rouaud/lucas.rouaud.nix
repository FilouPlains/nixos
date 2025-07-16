{ config, pkgs, ... }:

{
  imports =
    [
      ../general_profile.nix
    ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "lucas.rouaud";
  home.homeDirectory = "/home/lucas.rouaud";
}
