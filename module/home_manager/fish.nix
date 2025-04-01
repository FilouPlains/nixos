{ config, lib, pkgs, ... }:

let
  path = /etc/nixos;
in
{
  programs.fish = {
    enable = true;

    # Everything that should be launch with the terminal.
    interactiveShellInit = /* fish */ ''
      # Disable fish greeting.
      set fish_greeting

      # Picture showing.
      fastfetch

      # Enable zoxide.
      zoxide init fish | source
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
    };

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

      # T
      t = "g --tree --icons --size";
      table = "g --statistic --all --table --table-style=unicode --title --relative-time --dir-first --sort name --git --time-style=long-iso";
      top = "btop";
      tree = "g --tree --icons --size";

    };

    # Define functions here.
    functions = {
      # C
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

      # M
      mkcd = {
        body = /* fish */ '' 
          mkdir -p $argv[1]
          cd $argv[1]
        '';
        description = "Create a directory and go inside it";
      };

      # S
      shift-audio = {
        body = /* fish */ ''
          # Get main volume.
          set __current_volume (pactl get-sink-volume (pactl get-default-sink) | string match -r "[0-9]+%")

          # If we are to "reverse-stereo", switch back to "normal".
          if test (pactl get-default-sink) = "reverse-stereo"
            # Get the "reverse-stereo" module id to unload it.
            set __module_id (pactl list modules short | grep "reverse_audio" | cut -f1)

            # Change back to "normal audio".
            pactl unload-module $__module_id
            pactl set-sink-volume (pactl get-default-sink) $__current_volume

            set --erase __module_id
          # Else, switch to "reverse-stereo".
          else
            pactl set-sink-volume (pactl get-default-sink) 100%

            # Shift left / right audio.
            pactl load-module module-remap-sink \
              sink_name=reverse-stereo \
              master=0 \
              channels=2 \
              master_channel_map=front-right,front-left \
              channel_map=front-left,front-right \
              sink_properties=device.description="reverse_audio"

            # Set default audio to the shifted one.
            pactl set-default-sink reverse-stereo

            # Set volume of the new sink to the same as the old one.
            pactl set-sink-volume (pactl get-default-sink) $__current_volume
          end

          set --erase __current_volume
        '';
        description = "Shift left and right audio.";
      };
    };

    plugins = with pkgs.fishPlugins; [
      { name = "fzf"; inherit (fzf) src; }
      { name = "grc"; inherit (grc) src; }
    ];
  };

  xdg.configFile."fish/completions/g.fish".source = "${path}/package/g/g.fish";
}
