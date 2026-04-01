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
  ];

  # Define your hostname.
  networking.hostName = baseNameOf ./.;

  # Allow inverting left / right speakers.
  home-manager.users."lucas.rouaud".shiftAudio.enable = true;
}
