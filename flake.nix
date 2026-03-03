{
  description = "WGU Computer Science and AI Undergrad Development Environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux"; # Adjust to "aarch64-linux" if using ARM
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true; # Required for IntelliJ and some AI libs
        config.cudaSupport = false;
      };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          # --- Java Stack (CS Classes: D286, D287, D288) ---
          jdk17 # WGU Frameworks classes typically target Java 17
          maven
          jetbrains.idea # Use idea-ultimate if you have a student license

          # --- Python & AI Stack (AI Classes & DSA: C949, C950, D430) ---
          (python312.withPackages (
            ps: with ps; [
              numpy
              pandas
              scikit-learn
              matplotlib
              seaborn
              jupyter
              tensorflow # For AI Engineering modules
              keras
              torch # Binary version is usually more stable on Nix
            ]
          ))

          # cudaPackages.cuda_nvcc
          # cudaPackages.cudatoolkit
          # --- Database & Tools (Data Management: D191) ---
          mariadb.client # WGU often uses MySQL/MariaDB
          git
          wget
        ];

        shellHook = ''
          echo "🎓 WGU CS & AI Environment Loaded"
          echo "Java: $(java -version 2>&1 | head -n 1)"
          echo "Python: $(python --version)"
          echo "-----------------------------------"
          echo "Note: Use 'jupyter notebook' to start your AI labs."
        '';
      };
    };
}
