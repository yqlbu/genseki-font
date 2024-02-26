{
  description = "A free font family derived from Source Han Sans";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let
        pkgs = (import nixpkgs) { inherit system; };
        pname = "genseki-gothic";
        version = "v1.501";
        meta = with pkgs.lib; {
          description = "A free font family derived from Source Han Sans";
          homepage = "https://github.com/ButTaiwan/genseki-font";
          license = licenses.ofl;
          platforms = platforms.linux;
          mainProgram = pname;
          maintainers = with maintainers; [ kev ];
        };
        font = with pkgs;
          stdenv.mkDerivation {
            name = pname;
            inherit version;
            src = ./ttc;
            installPhase = ''
              install -Dm444 *.ttc -t $out/share/fonts/opentype/${pname}
            '';
            inherit meta;
          };
      in
      {
        # build package
        packages = {
          default = font;
          genseki-gothic = font;
        };
      });
}
