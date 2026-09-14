{
  description = "Underwater Desert Blogging development tools";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [ "aarch64-darwin" "aarch64-linux" "x86_64-darwin" "x86_64-linux" ];
      forEachSystem = nixpkgs.lib.genAttrs systems;
    in
    {
      devShells = forEachSystem (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          default = pkgs.mkShell {
            packages = [ pkgs.nodejs_24 pkgs.corepack_24 pkgs.biome ];

            shellHook = ''
              export BIOME="${pkgs.biome}/bin/biome"
            '';
          };
        });
    };
}
