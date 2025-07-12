# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [
      # ======
      # Module
      # ======
      # U
      ./nix_asset/module/users.nix
    ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.userList = [
    {
      name = "rouaud";
      description = "Lucas ROUAUD";
      extraGroups = [ "wheel" "networkmanager" "audio" ];
    }
    {
      name = "root";
      description = "System administrator";
      extraGroups = [ "wheel" ];
      isNormalUser = false;
    }
  ];
}
