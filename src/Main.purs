module Main where

import Prelude

import Data.Symbol (SProxy(..))
import Effect (Effect)
import Effect.Console (log)
import Prim.Symbol as Symbol

breakOnSymbol
  :: forall breakOn sym first second
   . Symbol.BreakOn breakOn sym first second
  => SProxy breakOn
  -> SProxy sym
  -> { first :: SProxy first, second :: SProxy second }
breakOnSymbol _ _ = { first: SProxy, second: SProxy }

-- inferred type:
result1 :: { first :: SProxy "a" , second :: SProxy ",b"}
result1 = breakOnSymbol (SProxy :: SProxy ",") (SProxy :: SProxy "a,b")

-- inferred type:
result2 :: { first :: SProxy "ab" , second :: SProxy ""}
result2 = breakOnSymbol (SProxy :: SProxy ",") (SProxy :: SProxy "ab")

joinSymbol
  :: forall breakOn sym first second
   . Symbol.BreakOn breakOn sym first second
  => SProxy breakOn
  -> SProxy first
  -> SProxy second
  -> SProxy sym
joinSymbol _ _ _ = SProxy

-- inferred type:
resultA :: SProxy "a,b"
resultA = joinSymbol (SProxy :: SProxy ",") (SProxy :: SProxy "a") (SProxy :: SProxy ",b")

-- inferred type, though hopelessly useless:
resultB :: forall t11. Symbol.BreakOn "," t11 "a" "b" => SProxy t11
resultB = joinSymbol (SProxy :: SProxy ",") (SProxy :: SProxy "a") (SProxy :: SProxy "b")

-- inferred type, also broken because the first contains the breaker, which is invalid:
resultC :: forall a. Symbol.BreakOn "," a "a," ",b" => SProxy a
resultC = joinSymbol (SProxy :: SProxy ",") (SProxy :: SProxy "a,") (SProxy :: SProxy ",b")

main :: Effect Unit
main = do
  log "Hello sailor!"
