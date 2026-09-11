{pkgs, ...}:{
  programs.taskwarrior = {
    enable = true;
    package = pkgs.taskwarrior3;
    config = {
      news.version = "3.3.1";
    };
  };
}
