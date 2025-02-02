{ pkgs, ... }:

let
  path = /etc/nixos;
in
{
  # Choosen color scheme.
  stylix.base16Scheme = "${path}/configuration_file/nord.yaml";

  # Mandatory, even if not used…
  stylix.image = ../img/wallpaper.png;
}
