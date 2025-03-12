{ config, lib, pkgs, ... }:

{
  programs.keychain = {
    enable = true;

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
