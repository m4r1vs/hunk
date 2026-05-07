{
  bun2nix,
  lib,
  ...
}: let
  packageJson = lib.importJSON ../package.json;
in
  bun2nix.mkDerivation {
    pname = "hunkdiff";
    version = packageJson.version;

    src = ../.;

    bunDeps = bun2nix.fetchBunDeps {
      bunNix = ./bun.lock.nix;
    };

    buildPhase = ''
      runHook preBuild
      bun build --compile "./src/main.tsx" --outfile "hunk"
      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall
      mkdir -p $out/bin
      cp ./hunk $out/bin/hunk
      runHook postInstall
    '';

    dontFixup = true;
  }
