# Edit this configuration file to define what should be installed on
# your system.

{ pkgs, ... }:

let
  path = /etc/nixos;
in
{
  # Declare manually installed packages.
  nixpkgs.config.packageOverrides = pkgs: {
    g = pkgs.callPackage "${path}/package/g/default.nix" { };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # B
    bat
    btop

    # C
    chromium

    # D
    discord

    # F
    fish
    fishPlugins.grc

    # G
    g
    git
    grc

    # H
    htop

    # I
    inkscape

    # K
    kitty

    # L
    lazygit
    libvlc

    # M
    mlocate

    # N
    nerdfonts
    neofetch
    neovim
    nixpkgs-fmt

    # P
    pulseaudio

    # S
    sl
    starship

    # V
    vesktop
    vlc

    # W
    wget

    # X
    xwaylandvideobridge
  ];
}
