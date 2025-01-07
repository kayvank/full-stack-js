{
  description = "A full-stack JS project";
  inputs = {
    pre-commit-hooks-nix.url = "github:cachix/pre-commit-hooks.nix";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    gitignore.url = "github:hercules-ci/gitignore.nix";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , gitignore
    , pre-commit-hooks-nix
    , ...
    }@inputs:

    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ ];
        config.allowUnfree = true;
      };


      checks = {
        pre-commit-check = pre-commit-hooks-nix.lib.${system}.run {
          src = ./.;
          hooks = {
            nixpkgs-fmt.enable = true;
            # fourmolu.enable = true;
            # eslint.enable = true;
            html-tidy.enable = true;
            markdownlint.enable = true;
          };
        };
      };

    in
    {
      devShells = {

        default = pkgs.mkShell {
          # inherit (self.checks.${system}.pre-commit-check) shellHook;
          buildInputs = with pkgs; [
            redis
            nodejs
            eslint
            pnpm
            nodePackages.prettier
            nodePackages.typescript
            nodePackages.typescript-language-server
            cowsay

          ];
          # Decorative prompt override so we know when we're in a dev shell
          shellHook = "${checks.pre-commit-check.shellHook}" + ''
            set -o vi
            cowsay "front-end dev env"
          '';
        };
      };

    });
  nixConfig = {
    extra-substituters = [ "https://cache.iog.io" ];
    extra-trusted-public-keys =
      [ "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ=" ];
    allow-import-from-derivation = true;
  };
}
