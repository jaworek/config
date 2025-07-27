{
  config,
  lib,
  pkgs,
  type,
  ...
}:

{
  programs.git = {
    enable = true;
    userName = "Jan Jaworski";
    userEmail = if type == "work" then "jan.jaworski@callstack.com" else "jaworek3211@gmail.com";
    extraConfig = {
      core.editor = "nvim";
      push.autoSetupRemote = true;
      init.defaultBranch = "master";
      pull.rebase = true;
      merge.conflictstyle = "zdiff3";
      core.pager = "delta";
      interactive.diffFilter = "delta --color-only";
      url."ssh://git@github.com/".insteadof = "https://github.com/";
      url."https://".insteadof = "git://";
      github.user = "jaworek";
      delta = {
        navigate = true;
      };
    };
  };
}
