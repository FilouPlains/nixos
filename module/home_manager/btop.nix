{ config, lib, pkgs, ... }:

{
  programs.btop = {
    enable = true;

    settings = {
      color_theme = "nord";
      theme_background = False;
      truecolor = False;
      force_tty = False;
      presets = "cpu:1:default,proc:0:default cpu:0:default,mem:0:default,net:0:default cpu:0:block,net:0:tty";
      vim_keys = False;
      rounded_corners = True;
      graph_symbol = "braille";
      shown_boxes = "cpu mem proc";
      update_ms = 2000;
      proc_sorting = "cpu lazy";
      temp_scale = "celsius";
      clock_format = "%X";
    };
  };
}
