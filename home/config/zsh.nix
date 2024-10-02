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

    plugins = with pkgs; [
      {
        name = "powerlevel10k";
        src = fetchFromGitHub {
          owner = "romkatv";
          repo = "powerlevel10k";
          rev = "087405df7838f4c3e835025699bd7b98b9731acc";
          sha256 = "115b23nzndd93ixhh6mykfmyjxcxpqyfrqmsdbkignxlwmzwv3kh";
        };
      file="powerlevel10k.zsh-theme";
      }
    ];

  };
}
