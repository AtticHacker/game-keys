module Test.GameKeys.Keys.API where

import Test.Tasty(TestTree, testGroup)
import Control.Monad.Writer(execWriter)
import Test.Tasty.QuickCheck as QC(testProperty)

import GameKeys.Keys.API
import GameKeys.Keys.Header

props :: TestTree
props = testGroup "GameKeys.Keys.API"
    [ bindstoProps
    , nestButtonProps
    , keyGroupProps
    , toStateProps
    ]

bindstoProps :: TestTree
bindstoProps = testGroup "bindsto properties"
    [ QC.testProperty "a `bindsto` b == [Button a b]" $ \(i, s) ->
      execWriter (i `bindsto` s) == [Button i s]

    , QC.testProperty "a `bindsto` b == [Button a b]" $ \(i, s) ->
      execWriter (i `bindsto` s) == [Button i s]
    , QC.testProperty "a `bindsto` b /= [Button a b] == False" $ \(i, s) ->
      (execWriter (i `bindsto` s) /= [Button i s]) == False

    ]

nestButtonProps :: TestTree
nestButtonProps = testGroup "nestButton properties"
    [ QC.testProperty "nestButton == [PrefixButton i [Button]]" $
      \(i, ni, ns) -> execWriter (nestButton i $ ni `bindsto` ns) ==
                      [PrefixButton i [Button ni ns]]
    , QC.testProperty "nestButton /= [PrefixButton i [Button]] == False" $
      \(i, ni, ns) -> (execWriter (nestButton i $ ni `bindsto` ns) /=
                      [PrefixButton i [Button ni ns]]) == False
    , QC.testProperty "nestedButton is same as button" $
      \(i, ni, ns) -> execWriter (nestButton i $ ni `bindsto` ns) ==
                      [PrefixButton i [Button ni ns]]
    , QC.testProperty "nestedButton is not the same as button == False" $
      \(i, ni, ns) -> (execWriter (nestButton i $ ni `bindsto` ns) /=
                      [PrefixButton i [Button ni ns]]) == False
    ]

keyGroupProps :: TestTree
keyGroupProps = testGroup "keyGroup properties"
    [ QC.testProperty "Group a [b] == [(a,[b])]" $ \(name, i, s) ->
       execWriter (keyGroup name $ i `bindsto` s) == [(name, [Button i s])]
    , QC.testProperty "Group a [b] /= [(a,[b])] == False" $ \(name, i, s) ->
       (execWriter (keyGroup name $ i `bindsto` s) /= [(name, [Button i s])])
       == False
    ]

toStateProps :: TestTree
toStateProps = testGroup "toStateProps"
    [ QC.testProperty "toState a b c == [StateButton b a c]" $ \(state, i, s) ->
       execWriter (toState state i s) == [StateButton i state s]
    , QC.testProperty "toState a b c /= [StateButton b a c] == False" $
      \(state, i, s) -> (execWriter (toState state i s) /=
                        [StateButton i state s]) == False

    ]