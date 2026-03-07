{ ... }:

{
  programs.git = {
    enable = true;
    settings.user.name = "jeroen";
    settings.user.email = "jeroen.vanrenterghem@student.hogent.be";
    settings = {
      init.defaultBranch = "main";
      core.ignorecase = "false";
      rebase.autoStash = "true";
      pull.rebase = "true";
      # windows only
      # core.autocrlf = "true";
      push.default = "simple";
    };
  };
}
