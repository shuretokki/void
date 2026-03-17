{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
  };

  outputs = inputs @ { flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.pre-commit-hooks.flakeModule
      ];

      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem = { config, pkgs, system, ... }: {
        pre-commit.settings.hooks = {
          eslint.enable = true;
          actionlint.enable = true;
        };

        devShells.default = pkgs.mkShell {
          shellHook = config.pre-commit.installationScript + ''
            export COREPACK_HOME="$PWD/.cache/corepack"
            export TYPST_FONT_PATHS="${pkgs.lib.makeSearchPath "share/fonts" [ pkgs.ibm-plex pkgs.montserrat pkgs.source-code-pro pkgs.jetbrains-mono ]}"
          '';

          packages = with pkgs; [
            nodejs_22
            corepack
            bun
            pnpm
            just
            typst
            typstyle
            typst-live
            oxipng
            jetbrains-mono
          ];
        };
      };
    };
}
