{ config, lib, pkgs, ... }: 

{
  programs.fish = {
    enable = true;

    interactiveShellInit = /* fish */ ''
      # Disable fish greeting.
      set fish_greeting
    '';

    shellAliases = {
      # C
      cat = "bat";

      # H
      htop = "btop";

      # L
      l = "g --all --title --dir-first --sort name --git --time-style=long-iso";
      ll = "g --all --title --dir-first --sort name --git --time-style=long-iso";
      ls = "g --icons --dir-first --sort name";

      # T
      table = "g --statistic --all --table --table-style=unicode --title --relative-time --dir-first --sort name --git --time-style=long-iso";
      top = "btop";
      tree = "g --tree --icons";
    };
  };
}
