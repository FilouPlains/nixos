# Declare manually installed packages.
{
  pkgs,
  lib,
  config,
  ...
}: let
  path = /etc/nixos/core/nix_asset/package;
in {
  nixpkgs.config.packageOverrides = pkgs: {
    g = pkgs.callPackage "${path}/g/default.nix" {};
    # nerd-fonts =
    #   pkgs.nerd-fonts
    #   // {
    #     inconsolata = import "${path}/inconsolata/default.nix" {
    #       inherit (pkgs) fetchzip;
    #       inherit (pkgs) lib;
    #       inherit (pkgs) nerd-fonts;
    #     };
    #   };
  };
}
