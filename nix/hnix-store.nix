self: super:
let
  # https://github.com/haskell-nix/hnix-store
  src = super.fetchFromGitHub {
    owner = "haskell-nix";
    repo = "hnix-store";
    rev = "2497d37d35eeed854875e9245c02bf538eaafa10";
    sha256 = "1xkj99ba4rc9mgd14bjsk170qvhmhrx00zz5bwml4737h3izl84k";
  };

  # swap with src to build from this path
  srcX = ../../hnix-store;

  subs = [
    "hnix-store-core"
    "hnix-store-remote"
  ];
in
{
  haskellPackages = super.haskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: super.lib.genAttrs subs (sub: hself.callCabal2nix sub "${src}/${sub}" {}));
    });
}
