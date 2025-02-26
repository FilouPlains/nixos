{ config, lib, pkgs, ... }:

let
  lib = import <nixpkgs/lib>;
in
{
  programs.starship = {
    enable = true;

    # Configuration written in `~/.config/starship.toml`.
    settings = {
      add_newline = true;

      format = builtins.concatStringsSep "" [
        "╭─[](#222222)"
	"$os"
	"$username"
	"$hostname"
	"$git_branch"
	"$git_status"
	"$directory[](#1b4469)"
	"$fill "
	"[](#222222)"
	"$time"
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
        style = "fg:#ffffff bg:#222222";
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
        style_user = "fg:#ffffff bg:#222222";
        style_root = "fg:#fbeeed bg:#222222";
        format = "[  $user ]($style)";
        show_always = true;
      };

      hostname = {
        disabled = false;
        style = "fg:#ffffff bg:#222222";
        ssh_only = false;
        ssh_symbol = "󰖟 ";
        format = "[ $ssh_symbol󰔂  $hostname ]($style)";
        trim_at = "";
      };

      time = {
        disabled = false;
        style = "fg:#ffffff bg:#222222";
        # hour:minute format
        time_format = "%R";
        format = "[   $time ]($style)";
      };

      directory = {
        disabled = false;
        style = "fg:#ffffff bg:#1b4469";
        truncation_length = 3;
        truncate_to_repo = false;
        format = "[   $path ]($style)";
        truncation_symbol = "…/";
        home_symbol = "~";
        use_os_path_sep = true;
      };

      status = {
        disabled = false;
        style = "fg:#ffffff bg:#950606";
        success_symbol = "[ 󰗡 ](fg:#ffffff bg:#008000)[](fg:#008000 bg:none)";
        symbol = "  $status[](fg:#950606 bg:none)";
        not_executable_symbol = "  $status[](fg:#950606 bg:none)";
        not_found_symbol = "  $status[](fg:#950606 bg:none)";
        sigint_symbol = "  $status[](fg:#950606 bg:none)";
        signal_symbol = "";
        format = "[$symbol]($style)";
      };

      git_branch = {
        disabled = false;
        symbol = " ";
        truncation_length = 4;
        truncation_symbol = "…";
        ignore_branches = [ ];
        style = "fg:#ffffff bg:#c9510c";
        format = "[ $symbol$branch ]($style)";
      };

      git_status = {
        conflicted = "🏳";
        ahead = "";
        behind = "";
        diverged = "";
        up_to_date = "";
        untracked = "?$count";
        stashed = "+$count";
        modified = "󰷥 $count";
        staged = "+$count";
        renamed = "󰗧$count";
        deleted = "󰇾 $count";
        style = "fg:#ffffff bg:#c9510c";
        format = "[$all_status ]($style)";
      };
    };
  };
}
