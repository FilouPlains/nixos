# Edit this configuration file to define what should be installed on                                                                                                                                                 
# your system.                                                                                                                                                                                                                     
{ pkgs, ... }:

{
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

    # G
    git

    # H
    htop

    # K
    kitty

    # L
    libvlc

    # M
    mlocate

    # N
    neofetch
    neovim
    nixpkgs-fmt

    # P
    pulseaudio

    # S
    sl

    # T
    tree

    # V
    vesktop
    vlc

    # W
    wget

    # X
    xwaylandvideobridge
  ];
}
