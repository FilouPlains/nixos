{ config, lib, pkgs, ... }:

{
  programs.fish = {
    enable = true;

    # Everything that should be launch with the terminal.
    interactiveShellInit = /* fish */ ''
      # Disable fish greeting.
      set fish_greeting
    '';

    # Alias over here.
    shellAliases = {
      # C
      c = "clear;ls";
      catf = "bat --style=plain --paging never --color never";

      # H
      htop = "btop";

      # L
      l = "g --all --title --dir-first --sort name --git --time-style=long-iso";
      lg = "lazygit";
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

    # Define functions here.
    functions = {
      mkcd = {
        body = /* fish */ '' 
          mkdir -p $argv[1]
          cd $argv[1]
        '';
        description = "mkdir and cd inside the created directory";
      };

      cat = {
        body = /* fish */ ''
          set path $argv

          if test $(count $path) -eq 1
            identify $path &> /dev/null 

            if test $status -eq 0
              kitten icat $path
            else
              bat --paging always $path
            end
          else
            for subpath in $(find $path -maxdepth 0)
              if test -d $subpath
                continue
              end

              identify $subpath &> /dev/null 

              if test $status -eq 0
                kitten icat $subpath
              else
                bat --paging never $subpath
              end
            end
          end
        '';
        description = "Cat files or images";
      };
    };

    plugins = with pkgs.fishPlugins; [
      { name = "grc"; inherit (grc) src; }
    ];
  };

  # home.activation.configure-tide = lib.hm.dag.entryAfter ["writeBoundary"] /* fish */ ''
  #   ${pkgs.fish}/bin/fish -c "tide configure --auto \
  #     --style=Classic \
  #     --prompt_colors='16 colors' \
  #     --show_time='24-hour format' \
  #     --classic_prompt_separators=Slanted \
  #     --powerline_prompt_heads=Round \
  #     --powerline_prompt_tails=Round \
  #     --powerline_prompt_style='Two lines, frame' \
  #     --prompt_connection=Disconnected \
  #     --powerline_right_prompt_frame=No \
  #     --prompt_spacing=Sparse \
  #     --icons='Many icons' \
  #     --transient=No"
  #   '';
}
