    let mkPackage =
          https://raw.githubusercontent.com/justinwoo/spacchetti/190618/src/mkPackage.dhall

in  let overrides =
          { typelevel-prelude =
              mkPackage
              [ "proxy", "prelude", "type-equality" ]
              "https://github.com/justinwoo/purescript-typelevel-prelude.git"
              "prim-boolean"
          }

in    https://raw.githubusercontent.com/justinwoo/spacchetti/190618/src/packages.dhall
    ⫽ overrides
