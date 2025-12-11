# Edit this configuration file to define what font should be installed on
# your system.
{pkgs, ...}: {
  fonts.packages = with pkgs; [
    # L
    liberation_ttf_v1

    # N
    nerd-fonts.sauce-code-pro
    noto-fonts
    noto-fonts-cjk-sans-static
    noto-fonts-cjk-serif-static

    # R
    roboto

    # T
    texlivePackages.cormorantgaramond
  ];
}
