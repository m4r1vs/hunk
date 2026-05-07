# Installing using Nix

Nix users can install Hunk from source instead of using npm.

1. Add Hunk to your nix flake inputs like such:

```nix
{
    inputs = {
        hunk = {
          url = "github:modem-dev/hunk";
          inputs.nixpkgs.follows = "nixpkgs";
        };
    }
}
```

2. Use in NixOS `environment.systemPackages` or `home.packages`:

```nix
{
    packages = [
        inputs.hunk.packages.${pkgs.stdenv.hostPlatform.system}.default
    ]
}
```

## Home Manager

Hunk provides a Home Manager module to manage both the package and its configuration.

1. Add the module to your Home Manager configuration:

```nix
{
  imports = [
    inputs.hunk.homeManagerModules.default
  ];

  programs.hunk = {
    enable = true;
    enableGitIntegration = true; # Optional: set hunk as default git pager
    settings = {
      theme = "graphite";
      mode = "split";
      line_numbers = true;
    };
  };
}
```

## Building using Nix

Simply run `nix build .#packages.{YOUR_SYSTEM}.default` where YOUR_SYSTEM is one of `x86_64-linux`, `x86_64-darwin`, `aarch64-linux` or `aarch64-darwin`. The resulting
Hunk binary will be `./result/bin/hunk`.
