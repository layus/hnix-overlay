self: super:
let
  # https://github.com/haskell-nix/hnix
  src = super.fetchFromGitHub {
    owner = "haskell-nix";
    repo = "hnix";
    rev = "pull/554/head";
    sha256 = "0155304d5z7kd60p810knfjd80lq1hhm69s6zb9ydaa4xlcq0zk2";
  };

  # swap with src to build from this path
  srcX = ../../hnix;
in
{
  haskellPackages = super.haskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        hnix = hself.callCabal2nix "hnix" "${src}" {};
      });
  });
}
