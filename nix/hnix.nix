self: super:
let
  # https://github.com/haskell-nix/hnix
  src = super.fetchFromGitHub {
    owner = "haskell-nix";
    repo = "hnix";
    rev = "pull/554/head";
    sha256 = "080gi0pzr6dgfhaw3vyz4n4v4dlj5g0jnvz5dafijajkvdsyyiwx";
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
