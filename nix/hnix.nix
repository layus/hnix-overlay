self: super:
let
  # https://github.com/haskell-nix/hnix
  src = super.fetchFromGitHub {
    owner = "haskell-nix";
    repo = "hnix";
    rev = "pull/554/head";
    sha256 = "1s5i1c8ykhpq1wdjfj79xm5lpspaq10yy33l5j0z798l1khb9yzp";
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
