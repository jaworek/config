### Project Overview

This project uses Nix and Nix-Darwin to declaratively manage a macOS environment. It leverages Nix Flakes for improved reproducibility and dependency management. Home Manager is used for managing user-specific configurations, including dotfiles and applications.

### Key Technologies

*   **Nix:** The core of the project, used for defining the entire system configuration in a declarative manner.
*   **Nix-Darwin:** Enables the use of Nix to manage macOS-specific settings.
*   **Home Manager:** Manages the user's home directory, including dotfiles, packages, and environment variables.
*   **Nix Flakes:** Used for dependency management and to ensure reproducible builds.

### Languages

*   **Nix Language:** The primary language for writing configuration files.
*   **Shell (Bash/Zsh):** Used for scripting and shell configurations.

### Code Style and Formatting

*   All Nix files (`.nix`) in this project should be formatted using `nixfmt-rfc-style`. This ensures a consistent code style across the project.

### Project Structure and Practices

*   **Declarative Configuration:** The system state is fully described in `.nix` files, promoting reproducibility and versioning.
*   **Infrastructure as Code (IaC):** The entire environment is treated as code, stored in a Git repository.
*   **Modular Design:** The configuration is split into logical files and directories, separating concerns such as system settings, user-level configurations, and application packages.
*   **Multiple Profiles:** The project supports different profiles (e.g., `personal` and `work`) to allow for context-specific configurations.
*   **Dotfiles Management:** Dotfiles are managed via Home Manager, ensuring they are version-controlled and consistently applied.
*   **Scripts for Automation:** Shell scripts are used to simplify common tasks like applying configuration changes.

### Directory Structure

*   `/`: The root of the project, containing the main Nix Flake file (`flake.nix`) and top-level configuration files.
*   `apps/`: Contains Nix files that define the application packages to be installed. It is further divided into `common.nix`, `personal.nix`, and `work.nix` to manage applications for different contexts.
*   `dotfiles/`: Stores the actual dotfiles (e.g., `.zshrc`, `tmux.conf`) that are symlinked into the home directory by Home Manager.
*   `home-manager/`: Contains Nix files that configure Home Manager and its various programs.
*   `hosts/`: Holds the main configuration files for different machines, with each file representing a specific host.
*   `macos/`: Contains macOS-specific configurations that are imported into the main `configuration.nix`.