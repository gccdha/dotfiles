{ ... }: {
  programs.hyprlock.enable = true;
  programs.hyprlock.settings = {
    general = {
      disable_loading_bar = false;
      hide_cursor = false;
      grace = 0;
      no_fade_in = false;
      no_fade_out = false;
      ignore_empty_input = false;
      immediate_render = false;
    };

    background = {
      path = "screenshot";
      color = "rgba(25, 20, 20, 1.0)";
      blur_passes = 3;
      blur_size = 8;
    };
  };
}
