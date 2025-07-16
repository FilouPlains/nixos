{ config, lib, pkgs, osConfig, ... }:

let
  stylix = osConfig.lib.stylix.colors;
in
{
  programs.starship = {
    enable = !builtins.elem "starship" osConfig.disabledPackage or true;

    # Configuration written in `~/.config/starship.toml`.
    settings = {
      add_newline = true;

      format = builtins.concatStringsSep "" [
        "╭─[](#${stylix.base03})"
        "$os"
        "$username"
        "$hostname"
        "$git_branch"
        "$git_status"
        "$directory[](#${stylix.base0C})"
        "$fill "
        "[](#${stylix.base03})"
        "$time"
        "$conda"
        "$status\n"
        "$character"
      ];

      right_format = "";

      character = {
        success_symbol = "╰─";
        error_symbol = "╰─";
      };

      fill = {
        symbol = " ";
      };

      os = {
        disabled = false;
        style = "fg:#ffffff bg:#${stylix.base03}";
        format = "[$symbol ]($style)";
        symbols = {
          Arch = "󰣇";
          Debian = "";
          Fedora = "";
          FreeBSD = "";
          Macos = "";
          Mint = "󰣭";
          NixOS = "󱄅";
          Raspbian = "";
          Redhat = "";
          RockyLinux = "";
          Ubuntu = "";
          Windows = "";
        };
      };

      username = {
        disabled = false;
        style_user = "fg:#ffffff bg:#${stylix.base03}";
        style_root = "fg:#fbeeed bg:#${stylix.base03}";
        format = "[  $user ]($style)";
        show_always = true;
      };

      hostname = {
        disabled = false;
        style = "fg:#ffffff bg:#${stylix.base03}";
        ssh_only = false;
        ssh_symbol = "󰖟 ";
        format = "[ $ssh_symbol󰔂  $hostname ]($style)";
        trim_at = "";
      };

      time = {
        disabled = false;
        style = "fg:#ffffff bg:#${stylix.base03}";
        # hour:minute format
        time_format = "%R";
        format = "[   $time ]($style)";
      };

      directory = {
        disabled = false;
        style = "fg:#ffffff bg:#${stylix.base0C}";
        truncation_length = 3;
        truncate_to_repo = false;
        format = "[   $path]($style)";
        truncation_symbol = "…/";
        home_symbol = "~";
        use_os_path_sep = true;
      };

      status = {
        disabled = false;
        style = "fg:#ffffff bg:#${stylix.base08}";
        success_symbol = "[ 󰗡 ](fg:#ffffff bg:#${stylix.base0B})[](fg:#${stylix.base0B} bg:none)";
        symbol = "  $status[](fg:#${stylix.base08} bg:none)";
        not_executable_symbol = "  $status[](fg:#${stylix.base08} bg:none)";
        not_found_symbol = "  $status[](fg:#${stylix.base08} bg:none)";
        sigint_symbol = "  $status[](fg:#${stylix.base08} bg:none)";
        signal_symbol = "";
        format = "[$symbol]($style)";
      };

      git_branch = {
        disabled = false;
        symbol = " ";
        truncation_length = 4;
        truncation_symbol = "…";
        ignore_branches = [ ];
        style = "fg:#ffffff bg:#${stylix.base09}";
        format = "[ $symbol$branch ]($style)";
      };

      git_status = {
        conflicted = " $count";
        ahead = "󱘨 $count";
        behind = "󱘥 $count";
        diverged = "⇡$ahead_count⇣$behind_count";
        up_to_date = "";
        untracked = "?$count";
        stashed = "+$count";
        modified = "󰷥 $count";
        staged = "+$count";
        renamed = "󰗧$count";
        deleted = "󰇾 $count";
        style = "fg:#ffffff bg:#${stylix.base09}";
        format = "[($all_status$ahead_behind )]($style)";
      };

      conda = {
        disabled = false;
        style = "fg:#ffffff bg:#7fb335";
        format = "[ $symbol$environment ]($style)";
        ignore_base = false;
        symbol = " ";
      };
    };
  };
}
