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
    fastfetch
    fd
    fish
    fishPlugins.fzf
    fishPlugins.grc
    fzf

    # G
    g
    gimp
    git
    grc

    # H
    htop

    # I
    imagemagick
    inkscape

    # K
    keychain
    kitty

    # L
    lazygit
    lf
    libreoffice
    libvlc

    # M
    mlocate

    # N
    nerdfonts
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
    xclip
    xwaylandvideobridge

    # Z
    zoxide
  ];
}
