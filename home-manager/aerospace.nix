{
  config,
  pkgs,
  ...
}:
{
  # Install aerospace package
  home.packages = with pkgs; [
    aerospace
    jankyborders
    sketchybar
  ];

  # Aerospace configuration
  home.file.".config/aerospace/aerospace.toml".source = ../dotfiles/aerospace/aerospace.toml;

  # Optional: Set up environment variables or other aerospace-related config
  home.sessionVariables = {
    # Add any aerospace-specific environment variables here if needed
  };

  # Optional: Add any aerospace-related shell aliases
  # These would be merged with your existing aliases in configuration.nix
  programs.bash.shellAliases = {
    # Example: shortcuts for aerospace commands
    # aerospace-reload = "aerospace reload-config";
  };
} 