{ ... }: {xdg.mimeApps = {
  enable = true;
  associations.added = {
    "application/pdf" = ["org.pwmt.zathura.desktop"];
  };
  defaultApplications = {
    "application/pdf" = ["org.pwmt.zathura.desktop"];
  };
};}
