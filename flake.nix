{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    repoMelange.url = "github:melange-re/melange/fork";
  };

  outputs = { self, nixpkgs, repoMelange }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" ];
      createDevShell = system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        pkgs.mkShell {
          buildInputs = [
            pkgs.nodejs-14_x
            pkgs.ocaml
            # pkgs.ocamlPackages.reason
            # pkgs.ocamlPackages.cmdliner
            pkgs.dune_3
            repoMelange.packages.${system}.default
            pkgs.ocamlPackages.ocaml-lsp
          ];
        };
    in
    {
      devShell = nixpkgs.lib.genAttrs supportedSystems createDevShell;
    };
}
