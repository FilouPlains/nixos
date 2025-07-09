{ config, lib, pkgs, osConfig, ... }:

{
  programs.ssh = {
    enable = !builtins.elem "ssh" osConfig.disabledPackage or true;
    startAgent = true;
  };
}
