{
  programs.kitty = {
    enable = true;
    settings = {
      font_size = "14.0";

      disable_ligatures = "never";


      scrollbar = "scrolled-and-hovered";

      scrollbar_radius = "0";

      progress_bar = "bottom";

      scrollback_pager_history_size = "1";

      pixel_scroll = "yes";


      mouse_hide_wait = "3.0";

      url_color = "#0087bd";
      url_style = "straight";

      background_opacity = "0.8";

      background_blur = "30";

      foreground = "#d8d8d8";
      background = "#181818";

      color0 =  "#181818";
      color1 =  "#ac4242";
      color2 =  "#90a959";
      color3 =  "#f4bf75";
      color4 =  "#6a9fb5";
      color5 =  "#aa759f";
      color6 =  "#75b5aa";
      color7 =  "#d8d8d8";

      color8 =  "#6b6b6b";
      color9 =  "#c55555";
      color10 = "#aac474";
      color11 = "#feca88";
      color12 = "#82b8c8";
      color13 = "#c28cb8";
      color14 = "#93d3c3";
      color15 = "#f8f8f8";

    }; 

    extraConfig = ''
      font_features    CaskaydiaCoveNFM-Regular +calt +ss01 +ss19
      font_features    CaskaydiaCoveNFM-Italic +ss01
      font_family      family='CaskaydiaCove Nerd Font Mono' postscript_name=CaskaydiaCoveNFM-Regular
      bold_font        family='CaskaydiaCove Nerd Font Mono' style=Bold
      italic_font      auto
      bold_italic_font family='CaskaydiaCove Nerd Font Mono' style='Bold Italic'
    '';

    shellIntegration = {
      mode = "no-cursor";
      enableZshIntegration = true;
    };
  };
}
