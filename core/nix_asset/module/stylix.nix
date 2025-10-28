{pkgs, ...}: let
  path = /etc/nixos/core/image;
in {
  # Colour theme.
  stylix.base16Scheme = {
    name = "nord";
    author = "arcticicestudio";
    variant = "dark";

    base00 = "2e3440";
    base01 = "3b4252";
    base02 = "434c5e";
    base03 = "4c566a";
    base04 = "d8dee9";
    base05 = "e5e9f0";
    base06 = "eceff4";
    base07 = "8fbcbb";
    base08 = "bf616a";
    base09 = "d08770";
    base0A = "ebcb8b";
    base0B = "a3be8c";
    base0C = "88c0d0";
    base0D = "81a1c1";
    base0E = "b48ead";
    base0F = "5e81ac";
  };

  stylix.polarity = "dark";

  # Mandatory, even if not used…
  stylix.image = "${path}/wallpaper.png";

  # Specify default fonts.
  stylix.fonts = {
    monospace = {
      package = pkgs.nerd-fonts.inconsolata;
      name = "Inconsolata";
    };

    sansSerif = {
      package = pkgs.roboto;
      name = "Roboto";
    };

    serif = {
      package = pkgs.liberation_ttf_v1;
      name = "LiberationSerif";
    };
  };

  # Specify default fonts size.
  stylix.fonts.sizes = {
    applications = 15;
    terminal = 15;
    desktop = 15;
    popups = 15;
  };
}
