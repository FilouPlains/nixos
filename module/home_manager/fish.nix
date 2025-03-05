{ config, lib, pkgs, ... }:

{
  programs.fish = {
    enable = true;

    # Everything that should be launch with the terminal.
    interactiveShellInit = /* fish */ ''
      # Disable fish greeting.
      set fish_greeting
    '';

    # Abbreviation. Difference with alias is expension!
    shellAbbrs = {
      # L
      lg = "lazygit";

      # N
      n = "nvim";

      # U
      update = "nixos-rebuild switch --flake /etc/nixos/#default --upgrade --impure";

      # V
      v = "nvim";
      vim = "nvim";
    }

    # Alias over here.
    shellAliases = {
      # C
      c = "clear;ls";
      catf = "bat --style=plain --paging never --color never";

      # H
      htop = "btop";

      # L
      l = "g --all --title --dir-first --sort name --git --time-style=long-iso";
      ll = "g --all --title --dir-first --sort name --git --time-style=long-iso";
      ls = "g --icons --dir-first --sort name";

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

  xdg.configFile."fish/completions/g.fish".source = "../../package/g/g.fish";
}
