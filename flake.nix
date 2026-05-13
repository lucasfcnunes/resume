{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };
  outputs =
    {
      self,
      nixpkgs,
      ...
    }:
    let
      infrastructureVersion = if (self ? shortRev) then self.shortRev else "dev";
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        # "x86_64-darwin"
        # "aarch64-darwin"
      ];
    in
    {
      overlay =
        final: prev:
        let
          pkgs = nixpkgs.legacyPackages.${prev.system};
        in
        rec { };
      devShells = builtins.listToAttrs (
        builtins.map (system: {
          name = system;
          value =
            let
              pkgs = import nixpkgs {
                inherit system;
                overlays = [ self.overlay ];
                # TODO: don't use unfree packages
                config.allowUnfreePredicate =
                  pkg:
                  builtins.elem (pkgs.lib.getName pkg) [
                    "steam-unwrapped"
                  ];
              };
              devDeps =
                with pkgs;
                [
                  nodejs
                  go-task
                ]
                ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
                  steam-run
                  xvfb-run
                  nspr
                  nss
                ];
            in
            {
              default = pkgs.mkShell {
                buildInputs = devDeps;
                shellHook = ''
                  # export DISPLAY=:9.0
                  export LD_LIBRARY_PATH=${
                    with pkgs;
                    lib.makeLibraryPath [
                      nspr
                      nss
                    ]
                  }:$LD_LIBRARY_PATH
                '';
              };
            };
        }) systems
      );
    };
}
