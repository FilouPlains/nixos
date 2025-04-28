# Edit this configuration file to define what should be installed on
# your system.

{ pkgs, lib, config, ... }:

let
  path = /etc/nixos;

  # Get enable packages by this
  enabledPackage = config.package.enable;

  filterOutPackage = lib.attrNames (lib.filterAttrs (_: isEnable: !isEnable) mySet);
  selectedPackage = package: lib.subtractLists (filterOutPackage enabledPackage) (package);
in
{
  options.package.enable = lib.mkOption {
    type = lib.types.attrsOf lib.types.bool;
    default = {};
    description = "Enable or disable system packages.";
  };

  config = {
    # Declare manually installed packages.
    nixpkgs.config.packageOverrides = pkgs: {
      g = pkgs.callPackage "${path}/package/g/default.nix" { };
    };

    package = [
      btop
      discord
      bat
      g
    ];

    environment.systemPackages = with pkgs; selectedPackage (package);
  }

  # # List packages installed in system profile. To search, run:
  # # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   # B
  #   batv
  #   btop

  #   # D
  #   discord

  #   # E
  #   exfat
  #   exfatprogs

  #   # F
  #   fastfetch
  #   fd
  #   fish
  #   fishPlugins.fzf
  #   fishPlugins.grc
  #   fzf

  #   # G
  #   g
  #   gimp
  #   git
  #   grc

  #   # H
  #   htop

  #   # I
  #   imagemagick
  #   inkscape

  #   # K
  #   keychain
  #   kitty

  #   # L
  #   lazygit
  #   libreoffice
  #   libvlc

  #   # M
  #   mlocate

  #   # N
  #   nerdfonts
  #   neovim
  #   nixpkgs-fmt
  #   nvimpager

  #   # P
  #   pulseaudio

  #   # S
  #   sl
  #   scrcpy
  #   starship

  #   # V
  #   vesktop
  #   vlc

  #   # W
  #   wget

  #   # X
  #   xclip
  #   xwaylandvideobridge

  #   # Y
  #   yazi

  #   # Z
  #   zoxide
  # ];
}

