# Edit this configuration file to define what font should be installed on
# your system.
{pkgs, ...}: {
  fonts.packages = with pkgs; [
    # L
    liberation_ttf_v1

    # N
    nerd-fonts.inconsolata

    # R
    roboto
  ];
}
