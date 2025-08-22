# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

let
  module_path = "/etc/nixos/core/nix_asset/module";
in
{
  imports =
    [
      # Other package setup.
      inputs.home-manager.nixosModules.default

      # ======
      # Module
      # ======
      # F
      "${module_path}/font.nix"

      # P
      "${module_path}/package.nix"

      # S
      "${module_path}/stylix.nix"

      # U
      "${module_path}/user/list.nix"
      "${module_path}/user/definition.nix"
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

  # Configure console keymap
  console.keyMap = "fr";

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

  # ====
  # User
  # ====
  user.userToAdd = [
    "root"
    "lucas.rouaud"
  ];

  # ====================
  # Locate package setup
  # ====================
  services.locate.enable = true;
  services.locate.package = pkgs.mlocate;
  services.locate.localuser = null;

  # =========================
  # Other NixOS configuration
  # =========================
  programs.fish.enable = true;
  stylix.enable = true;

  # Auto-start ssh.
  programs.ssh.startAgent = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix.settings.auto-optimise-store = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  #
  # Before changing this value read the documentation for this option
  # (`$ man configuration.nix` or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05";
}
