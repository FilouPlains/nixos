{ config, lib, pkgs, osConfig, ... }:

{
  programs.keychain = {
    enable = (!builtins.elem "keychain" osConfig.disabledPackage) or true;

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
