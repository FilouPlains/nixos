{ config, lib, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    
    settings = {
      font_size = 15;
      font_family = "Inconsolata Light";
      bold_font = "Inconsolata Black";
    };
  };
}
