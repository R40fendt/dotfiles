{
		description="My Dotfiles";

		inputs = {    
				home-manager = {
					url = "github:nix-community/home-manager";
					inputs.nixpkgs.follows = "nixpkgs";
				};

				hyprkcs.url = "github:kosa12/hyprKCS";
	
				nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		};

		outputs = { self, nixpkgs, home-manager, hyprkcs, ... }: {
				homeModules.default = { config, pkgs, ... }: {
						home.stateVersion="24.05";
						home.packages = [
										hyprkcs
						];
				};
		};
}
