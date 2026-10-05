{
  description = "Go + NPM";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          git
          go
          gopls
          air
          pnpm
          nodejs
        ];

        buildInputs = [
          pkgs.postgresql
        ];

        shellHook = ''
          export GOPATH="$PWD/.go"
          export PATH="$GOPATH/bin:$PATH"
        '';
      };
    };
}
