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
  };
}
