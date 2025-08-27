# Edit this configuration file to define what should be installed on
# your system.

{ pkgs, lib, config, inputs, ... }:

let
  path = /etc/nixos;

  /** 
    Recursively navigates a nested attribute set using a list of strings as keys.
    
    Example
    -------
    Here how will work the loop:
    - **Input:** `source [ a b c ]`
    
    1. `source.a`     [ b c ]
    2. `source.a.b`   [ b ]
    3. `source.a.b.c`

    Note that here, we transform a `str` like `"a.b.c"` into the `[ a b c ]` list.
    
    Parameters
    ----------
    source : `AttrSet`  
        The attribute set to navigate.
    
    list : `listOf str`  
        A list of strings representing the path of keys to traverse.
    
    Returns
    -------
    `Any`  
        The value located at the end of the path within the attribute set.
  */
  getSubPackage = (source: list:
    if builtins.length list == 1 then
      builtins.getAttr (builtins.elemAt list 0) (source)
    else
      getSubPackage (builtins.getAttr (builtins.elemAt list 0) (source)) (builtins.tail list)
  );

  /** 
    Selects enabled packages (filtering out those in `config.disabledPackage`), then
    gets their values from the `pkgs` attribute.
    
    Parameters
    ----------
    packageList : `listOf str`  
        A list of dot-separated package names (`"languages.python.numpy"`).
    
    Returns
    -------
    `listOf Any`  
        A list of resolved package values from `pkgs`, excluding any disabled packages.
  */
  selectedPackage = packageList: (lib.subtractLists config.disabledPackage packageList) |>
    builtins.map (packageName: lib.strings.splitString "." packageName) |>
  builtins.map (packageNameList: getSubPackage pkgs packageNameList);
in
{
  imports =
    [
      ../package/own_package_definition.nix
    ];

  options.disabledPackage = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
    description = "List of system packages to disable.";
  };

  config = {
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = selectedPackage ([
      # B
      "bat"
      "btop"

      # D
      "discord"
      "dysk"

      # E
      "exfat"
      "exfatprogs"

      # F
      "fastfetch"
      "fd"
      "firefox"
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
      "htop"

      # I
      "imagemagick"
      "inkscape"

      # K
      "keychain"
      "kitty"
      "krita"

      # L
      "lazygit"
      "libreoffice-qt6-fresh"
      "libvlc"

      # M
      "mlocate"

      # N
      "nerdfonts"
      "neovim"
      "nh"
      "nixpkgs-fmt"
      "nix-output-monitor"
      "nvimpager"

      # P
      "pulseaudio"

      # S
      "sl"
      "scrcpy"
      "starship"

      # U
      "unzip"

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
      "zathura"
      "zoom-us"
      "zoxide"
    ]);
  };
}

