module GameKeys.Keys.API where

import GameKeys.Keys.Header
import Control.Monad.Writer

-- | Binds a Gamepad Key to an output String
--  example: 1 `bindsto` "foo"
--  Pressing button 1 will output "foo"
bindsto :: Int -> String -> Layout
bindsto a b = tell [Button a b]

-- | Nests Gamepad Keys in a single Gamepad Key
--  example: nestButton 1 $ do
--             button 2 `bindsto` "bar"
--  Pressing 2 while holding 1 outputs "bar"
nestButton :: Int -> Layout -> Layout
nestButton a b = tell [PrefixButton a (execWriter b)]

-- | Nests Keys in a single state group
-- example: keyGroup "Main" $ do
--             1 `bindsto` "baz"
-- Pressing 1 will only output "baz" while in the "Main state"
keyGroup :: String -> Layout -> GroupLayout
keyGroup n l = tell [(n, execWriter l)]

-- | Switches state and outputs String
-- example: toState "main" 1 "m"
-- Pressing 1 will switch to the "main" state and output "m"
toState :: String -> Int -> String -> Layout
toState st b keys = tell [StateButton b st keys]
