{
  description = "Description for the project";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { pkgs, ... }: let 
        pythonEnv = pkgs.python3.withPackages (python-pkgs: with python-pkgs; [
          django
          jinja2
        ]);
      in {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            nixd
            nixpkgs-fmt

            pythonEnv
          ];
        };
 
        apps = let 
          debug = pkgs.writeShellApplication {
            name = "debug.sh";

            runtimeInputs = [
              pythonEnv
            ];

            text = ''
              
            '';
          };
        in  {
          debug.program = "${debug}/bin/debug.sh";
        };
      };
    };
}
