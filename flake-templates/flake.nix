{
  description = "templates made by realram";

  outputs = {self}: {
    templates = {
      devshell = {
        path = ./devshell;
        description = "devshell template with hook";
      };
    };

    defaultTemplate = self.templates.devshell;
  };
}
