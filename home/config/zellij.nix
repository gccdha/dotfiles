{
  programs.zellij = {
    enable = true;
    enableZshIntegration = false; # makes it startup automatically for any zsh session
    settings = {
      theme = "tokyo-night-dark";
      mouse_click_through = false; # is the first click on a pane used in whatever is open in that pane (true) or consumed by zellij (false)
      stacked_pane_list = false; # show a list of the titles of stacked panes
      scrollback_editor = "nvim";
      show_startup_tips = false;
      #TODO: install https://github.com/karimould/zellij-forgot
      # also look at https://github.com/rvcas/room
    };
  };
}
