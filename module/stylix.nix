{ pkgs, ... }:

# let
#   path = /etc/nixos;
# in
{
  # Choosen color scheme.
  stylix.base16Scheme = "../configuration_file/nord.yaml";
  stylix.polarity = "dark";

  # Mandatory, even if not used…
  stylix.image = null;#"../img/wallpaper.png";

  # Specify default fonts.
  stylix.fonts = {
    monospace = {
      package = pkgs.nerdfonts.override {fonts = ["Inconsolata"];};
      name = "Inconsolata Nerd Font";
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
