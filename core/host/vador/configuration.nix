{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include other nix files.
    ../general_configuration.nix
    ./hardware.nix
    ../../nix_asset/module/eduoram.nix
  ];

  # Define your hostname.
  networking.hostName = baseNameOf ./.;

  # ===============
  # Package gestion
  # ===============
  disabledPackage = [
    "krita"
  ];
}
