module GameKeys.Keys.Header where

import Control.Monad.Writer

data Button = Button (Int, String)
            | PrefixButton (Int, [Button])
            | StateButton (Int, String, String)
              deriving Show

type Layout = Writer [Button] ()
type GroupLayout = Writer [(String, [Button])] ()
