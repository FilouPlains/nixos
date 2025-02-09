{ config, lib, pkgs, ... }: 

{
  programs.fish = {
    enable = true;
    interactiveShellInit = /* fish */ ''
      # Disable fish greeting.
      set fish_greeting
    '';
  };
}
