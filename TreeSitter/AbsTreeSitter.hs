-- File generated by the BNF Converter (bnfc 2.9.5).

{-# LANGUAGE GeneralizedNewtypeDeriving #-}

-- | The abstract syntax of language TreeSitter.

module AbsTreeSitter where

import Prelude (String)
import qualified Prelude as C (Eq, Ord, Show, Read)
import qualified Data.String

data TreeSitterGrammar = TreeSitterGrammar Preamble GrammarBody
  deriving (C.Eq, C.Ord, C.Show, C.Read)

data Preamble = Preamble [ConstDecl]
  deriving (C.Eq, C.Ord, C.Show, C.Read)

data ConstDecl = ConstDecl Id String
  deriving (C.Eq, C.Ord, C.Show, C.Read)

data GrammarBody = GrammarBody Name Rules
  deriving (C.Eq, C.Ord, C.Show, C.Read)

data Name = Name String
  deriving (C.Eq, C.Ord, C.Show, C.Read)

data Rules = Rules [Rule]
  deriving (C.Eq, C.Ord, C.Show, C.Read)

data Rule = Rule Id Expression
  deriving (C.Eq, C.Ord, C.Show, C.Read)

data Expression
    = Choice [Expression]
    | Seq [Expression]
    | Repeat Expression
    | Symbol Id
    | Const Id
    | Literal String
    | Regex String
  deriving (C.Eq, C.Ord, C.Show, C.Read)

newtype Id = Id String
  deriving (C.Eq, C.Ord, C.Show, C.Read, Data.String.IsString)

