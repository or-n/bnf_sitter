-- File generated by the BNF Converter (bnfc 2.9.5).

-- Templates for pattern matching on abstract syntax

{-# OPTIONS_GHC -fno-warn-unused-matches #-}

module SkelRustRegex where

import Prelude (($), Either(..), String, (++), Show, show)
import qualified AbsRustRegex

type Err = Either String
type Result = Err String

failure :: Show a => a -> Result
failure x = Left $ "Undefined case: " ++ show x

transNumber :: AbsRustRegex.Number -> Result
transNumber x = case x of
  AbsRustRegex.Number string -> failure x

transName :: AbsRustRegex.Name -> Result
transName x = case x of
  AbsRustRegex.Name string -> failure x

transRustRegexGrammar :: AbsRustRegex.RustRegexGrammar -> Result
transRustRegexGrammar x = case x of
  AbsRustRegex.ConcatGrammar concat -> failure x
  AbsRustRegex.Class class_ repeat -> failure x
  AbsRustRegex.Alt rustregexgrammar1 rustregexgrammar2 -> failure x
  AbsRustRegex.Group rustregexgrammar repeat -> failure x

transClass :: AbsRustRegex.Class -> Result
transClass x = case x of
  AbsRustRegex.ConcatClass concat -> failure x
  AbsRustRegex.Seq classs -> failure x
  AbsRustRegex.Except classs -> failure x
  AbsRustRegex.Range char1 char2 -> failure x
  AbsRustRegex.Ascii -> failure x
  AbsRustRegex.NotAscii -> failure x
  AbsRustRegex.Intersect class_1 class_2 -> failure x
  AbsRustRegex.Subtract class_1 class_2 -> failure x
  AbsRustRegex.SymmetricDiff class_1 class_2 -> failure x
  AbsRustRegex.Nest class_ -> failure x

transConcat :: AbsRustRegex.Concat -> Result
transConcat x = case x of
  AbsRustRegex.Char mychar -> failure x
  AbsRustRegex.Escape mychar -> failure x
  AbsRustRegex.Character character -> failure x

transCharacter :: AbsRustRegex.Character -> Result
transCharacter x = case x of
  AbsRustRegex.AnyExceptNewline -> failure x
  AbsRustRegex.Digit -> failure x
  AbsRustRegex.NotDigit -> failure x
  AbsRustRegex.UnicodeLetter -> failure x
  AbsRustRegex.NotUnicodeLetter -> failure x
  AbsRustRegex.LetterClass name -> failure x
  AbsRustRegex.NotLetterClass name -> failure x

transRepeat :: AbsRustRegex.Repeat -> Result
transRepeat x = case x of
  AbsRustRegex.Many -> failure x
  AbsRustRegex.Some -> failure x
  AbsRustRegex.Optional -> failure x
  AbsRustRegex.ManyLazy -> failure x
  AbsRustRegex.SomeLazy -> failure x
  AbsRustRegex.OptionalLazy -> failure x
  AbsRustRegex.LeastMost number1 number2 -> failure x
  AbsRustRegex.Least number -> failure x
  AbsRustRegex.Exactly number -> failure x
  AbsRustRegex.LeastMostLazy number1 number2 -> failure x
  AbsRustRegex.LeastLazy number -> failure x
  AbsRustRegex.ExactlyLazy number -> failure x
  AbsRustRegex.No -> failure x

transEmpty :: AbsRustRegex.Empty -> Result
transEmpty x = case x of
  AbsRustRegex.Start -> failure x
  AbsRustRegex.End -> failure x
  AbsRustRegex.OnlyStart -> failure x
  AbsRustRegex.OnlyEnd -> failure x
  AbsRustRegex.UnicodeBoundary -> failure x
  AbsRustRegex.NotUnicodeBoundary -> failure x

transMyChar :: AbsRustRegex.MyChar -> Result
transMyChar x = case x of
  AbsRustRegex.Quote -> failure x
  AbsRustRegex.EscapeChar -> failure x
  AbsRustRegex.Other char -> failure x
