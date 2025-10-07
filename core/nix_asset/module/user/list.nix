# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # ======
    # Module
    # ======
    # U
    ./definition.nix
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  user.userList = [
    {
      name = "lucas.rouaud";
      description = "Lucas ROUAUD";
      extraGroups = ["wheel" "networkmanager" "audio"];
    }
    {
      name = "root";
      description = "System administrator";
      extraGroups = ["wheel" "networkmanager"];
      isNormalUser = false;
    }
    {
      name = "patrick.rouaud";
      description = "Patrick ROUAUD";
      extraGroups = ["networkmanager"];
    }
    {
      name = "sergio.romano";
      description = "Sergio ROMANO";
      extraGroups = ["networkmanager"];
    }
    {
      name = "renee.romano";
      description = "Renée ROMANO";
      extraGroups = ["networkmanager"];
    }
  ];
}
