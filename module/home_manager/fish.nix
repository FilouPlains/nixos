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
      c = "clear;ls";
      cat = "bat";
      catf = "bat --style=plain --paging never --color never";

      # H
      htop = "btop";

      # L
      l = "g --all --title --dir-first --sort name --git --time-style=long-iso";
      ll = "g --all --title --dir-first --sort name --git --time-style=long-iso";
      ls = "g --icons --dir-first --sort name";

      # N
      n = "nvim";

      # O
      off = "shutdown now";

      # S
      shift-audio = ''pactl load-module module-remap-sink \
			    sink_name=reverse-stereo \
                            master=0 \
                            channels=2 \
                            master_channel_map=front-right,front-left \
                            channel_map=front-left,front-right'';

      # T
      t = "g --tree --icons --size";
      table = "g --statistic --all --table --table-style=unicode --title --relative-time --dir-first --sort name --git --time-style=long-iso";
      top = "btop";
      tree = "g --tree --icons --size";

      # U
      update = "nixos-rebuild switch --flake /etc/nixos/#default --upgrade --impure";

      # V
      vim = "nvim";
    };
  };
}
