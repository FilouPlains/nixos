# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [
      # Include other nix files.
      ./font.nix
      ./package.nix

      # Other package setup.
      inputs.home-manager.nixosModules.default

      # ======
      # Module
      # ======
      # U
      ../nix_asset/module/users.nix
    ];

  # ===========
  # Boot loader
  # ===========
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
    "pipe-operators"
  ];

  # ============
  # Connectivity
  # ============
  # Enable networking.
  networking.networkmanager.enable = true;

  # Enable blutooth.
  hardware.bluetooth.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # ========
  # Language
  # ========
  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # ===================
  # Desktop environment
  # ===================
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "fr";
    variant = "oss";
  };

  # Configure console keymap
  console.keyMap = "fr";

  # =====
  # Audio
  # =====
  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.userList = [
    {
      name = "rouaud";
      description = "Lucas ROUAUD";
      extraGroups = [ "wheel" "networkmanager" "audio" ];
      homeManagerPath = ./home/rouaud.nix;
    }
    {
      name = "root";
      description = "System administrator";
      extraGroups = [ "wheel" ];
      isNormalUser = false;
      homeManagerPath = ./home/root.nix;
    }
  ];

  home-manager = {
    # Also pass inputs to home-manager modules.
    extraSpecialArgs = { inherit inputs; };
    users = {
      "rouaud" = import ;
      "root" = import ;
    };
  };

  # ====================
  # Locate package setup
  # ====================
  services.locate.enable = true;
  services.locate.package = pkgs.mlocate;
  services.locate.localuser = null;

  # =========================
  # Other NixOS configuration
  # =========================
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Automatic cleaning.
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 15d";
  };

  nix.settings.auto-optimise-store = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05";
}
