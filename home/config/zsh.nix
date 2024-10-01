{ pkgs, config, ... }:{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    autocd = true;
    dotDir = ".config/zsh";

    history = {
      size = 10000;
      save = 10000;
      path = "${config.xdg.configHome}/zsh/history";
      append = true;
      expireDuplicatesFirst = true;
      ignoreAllDups = true;
      ignoreDups = true;
      ignoreSpace = true;
    };

    plugins = [
      pkgs.zsh-powerlevel10k
    ];

  };
}
