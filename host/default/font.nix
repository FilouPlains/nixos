# Edit this configuration file to define what font should be installed on
# your system.

{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
  # For NerdFont installation.
  (nerdfonts.override {
    fonts = [ "Inconsolata" ];
  })

  # I
  inconsolata

  # L
  liberation_ttf_v1

  # R
  roboto
  ];
}
