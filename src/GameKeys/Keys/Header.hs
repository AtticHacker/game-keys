{-# LANGUAGE GADTs #-}

module GameKeys.Keys.Header where

import Control.Monad.Writer

data Button = Button { buttonID :: Int
                     , buttonOutput :: String
                     }
            | PrefixButton { prefixID   :: Int
                           , buttonList :: [Button]
                           }
            | StateButton  { stateID     :: Int
                           , stateName   :: String
                           , stateOutput :: String
                           }
              deriving (Show, Eq)

type Layout = Writer [Button] ()
type GroupLayout = Writer [(String, [Button])] ()
