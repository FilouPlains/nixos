{ config, lib, pkgs, osConfig, ... }:

{
  programs.ssh = {
    enable = osConfig.enablePackage.ssh or true;
    startAgent = true;
  };
}
