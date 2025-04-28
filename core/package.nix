# Edit this configuration file to define what should be installed on
# your system.

{ pkgs, lib, config, ... }:

let
  path = /etc/nixos;

  optionalPackage = name: lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enable the ${name} package.";
  };

  togglePackage = lib.genAttrs (map
    (name: "enable${lib.strings.capitalize name}" packageName)
    (name: optionalPackage name)
  );
in
{
  options.enablePackage = {
    enable = lib.mkEnableOption "Enable package enabling module.";

    listPackage = togglePackage;
  }

  config = {
    # Declare manually installed packages.
    nixpkgs.config.packageOverrides = pkgs: {
      g = pkgs.callPackage "${path}/package/g/default.nix" { };
    };


    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs;  
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

