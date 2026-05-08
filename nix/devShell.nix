{
  pkgs,
  bun2nix,
}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    bun
    bun2nix
    git
    nodejs
  ];
}
