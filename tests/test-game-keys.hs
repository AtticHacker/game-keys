module Main where

import Test.Tasty(TestTree, testGroup, defaultMainWithIngredients)
import Test.Tasty.Runners(Ingredient, listingTests, consoleTestReporter)

import Test.GameKeys.Keys.API as Keys.API

tests :: TestTree
tests = testGroup "Tests" [Keys.API.props]

ingredients :: [Ingredient]
ingredients = [listingTests, consoleTestReporter]

main :: IO ()
main = defaultMainWithIngredients ingredients tests
