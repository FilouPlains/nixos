# Edit this configuration file to define what should be installed on
# your system.

{ pkgs, lib, config, ... }:

let
  path = /etc/nixos;

  filterOutPackage = lib.attrNames (lib.filterAttrs (_: isEnable: !isEnable) config.enablePackage);
  selectedPackage = packageList: (lib.filterAttrs (packageName: _: !(builtins.elem packageName filterOutPackage)) packageList) |> builtins.attrValues;
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  defaultPackage = with pkgs; [
    # B
    bat
    btop

    # D
    discord

    # E
    exfat
    exfatprogs

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
    libreoffice
    libvlc

    # M
    mlocate

    # N
    nerdfonts
    neovim
    nixpkgs-fmt
    nvimpager

    # P
    pulseaudio

    # S
    sl
    scrcpy
    starship

    # V
    vesktop
    vlc

    # W
    wget

    # X
    xclip
    xwaylandvideobridge

    # Y
    yazi

    # Z
    zoxide
  ] |> builtins.map (packageItem: {name = packageItem.pname; value = packageItem;}) |> builtins.listToAttrs;
in
{
  options.enablePackage = lib.mkOption {
    type = lib.types.attrsOf lib.types.bool;
    default = {};
    description = "Enable or disable system packages.";
  };

  config = {
    # Declare manually installed packages.
    nixpkgs.config.packageOverrides = pkgs: {
      g = pkgs.callPackage "${path}/package/g/default.nix" { };
    };

    environment.systemPackages = with pkgs; selectedPackage (defaultPackage);
  };
}

