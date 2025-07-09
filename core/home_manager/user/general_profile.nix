{ config, pkgs, ... }:

{
  imports =
    [
      ../package_setup/package_setup.nix
    ];
  # Do not change this value.
  # If you want to do so, check `Home Manager release notes`.
  home.stateVersion = "24.05";

  home.sessionVariables = {
    EDITOR = "nvim";
    MANROFFOPT "-P -c";
    MANPAGER = "nvimpager";
    PAGER = "nvimpager";
    COLORTERM = "truecolor";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  stylix.enable = true;
}
