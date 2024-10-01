{ pkgs, config, ... }:{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
  };
}
