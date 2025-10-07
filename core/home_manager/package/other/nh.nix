{
  config,
  lib,
  pkgs,
  osConfig,
  ...
}: {
  programs.nh = {
    enable = !builtins.elem "nh" osConfig.disabledPackage or true;

    clean.enable = true;
    clean.extraArgs = "--keep-since 15d --keep 3";

    flake = "/etc/nixos";
  };
}
