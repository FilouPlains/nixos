# Edit this configuration file to define what should be installed on
# your system.

{ pkgs, lib, config, ... }:

let
  path = /etc/nixos;

  filterOutPackage = lib.attrNames (lib.filterAttrs (_: isEnable: !isEnable) config.enablePackage);
  
  /*selectedPackage = packageList: (lib.subtractLists filterOutPackage packageList) |>
    builtins.map (packageName: lib.strings.splitString "." packageName) |>
    builtins.map (packageNameList: getSubPackage pkgs packageNameList);
*/
  selectedPackage = packageList: (lib.subtractLists config.disabledPackage packageList) |>
    builtins.map (packageName: lib.strings.splitString "." packageName) |>
    builtins.map (packageNameList: getSubPackage pkgs packageNameList);

  getSubPackage = (source: list:
    if builtins.length list == 1 then
      builtins.getAttr (builtins.elemAt list 0) (source)
    else
      getSubPackage (builtins.getAttr (builtins.elemAt list 0) (source)) (builtins.tail list)
  );
in
{
  options.enablePackage = lib.mkOption {
    type = lib.types.attrsOf lib.types.bool;
    default = {};
    description = "Enable or disable system packages.";
  };

  options.disabledPackage = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [];
    description = "List of system packages to disable.";
  };


  config = {
    # Declare manually installed packages.
    nixpkgs.config.packageOverrides = pkgs: {
      g = pkgs.callPackage "${path}/package/g/default.nix" { };
    };

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = selectedPackage ([
      # B
      "bat"
      "btop"

      # D
      "discord"

      # E
      "exfat"
      "exfatprogs"

      # F
      "fastfetch"
      "fd"
      "fish"
      "fishPlugins.fzf"
      "fishPlugins.grc"
      "fzf"

      # G
      "g"
      "gimp"
      "git"
      "grc"

      # H
      "home-manager"
      "htop"

      # I
      "imagemagick"
      "inkscape"

      # K
      "keychain"
      "kitty"

      # L
      "lazygit"
      "libreoffice-qt6-fresh"
      "libvlc"

      # M
      "mlocate"

      # N
      "nerdfonts"
      "neovim"
      "nixpkgs-fmt"
      "nvimpager"

      # P
      "pulseaudio"

      # S
      "sl"
      "scrcpy"
      "starship"

      # V
      "vesktop"
      "vlc"

      # W
      "wget"

      # X
      "xclip"
      "xwaylandvideobridge"

      # Y
      "yazi"

      # Z
      "zoom-us"
      "zoxide"
  ]);
  };
}

