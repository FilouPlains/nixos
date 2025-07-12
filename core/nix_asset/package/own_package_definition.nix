# Declare manually installed packages.

{ pkgs, lib, config, ... }:

{
  nixpkgs.config.packageOverrides = pkgs: {
    g = pkgs.callPackage "g/default.nix" { };
  };
}

