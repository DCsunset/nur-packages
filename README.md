# nur-packages

**My personal [NUR](https://github.com/nix-community/NUR) repository**

<!-- Remove this if you don't use github actions -->
![Build and populate cache](https://github.com/DCsunset/nur-packages/workflows/Build%20and%20populate%20cache/badge.svg)
[![Cachix Cache](https://img.shields.io/badge/cachix-dcsunset-blue.svg)](https://dcsunset.cachix.org)


## Usage

To use this repo directly without the whole NUR namespace,
add the following to your `flake.nix` config:

```nix
{
	inputs = {
		nur-dcsunset = {
			url = "github:DCsunset/nur-packages";
		};
	};

	outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # Add packages from this repo
				{
					nixpkgs.overlays = [ inputs.nur-dcsunset.overlays.pkg ];
				}

        # Binary cache (optional)
        ({ ... }: {
          nix.settings.substituters = [ "https://dcsunset.cachix.org" ];
          nix.settings.trusted-public-keys = [ "dcsunset.cachix.org-1:EGXkNb1C+03/dYGG5QOFt9cXIiZcuwMLDcdZw1wlkU0=" ];
        })
      ];
    };
  };
}
```

