{ config, lib, pkgs, osConfig, ... }:

{
  programs.keychain = {
    enable = osConfig.enablePackage.keychain or true;

    keys = [
      "github_id_rsa"
    ];

    agents = [ "ssh" ];

    extraFlags = [
      "--inherit any"
      "--quiet"
    ];
  };
}
