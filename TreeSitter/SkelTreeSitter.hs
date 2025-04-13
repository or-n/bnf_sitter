-- File generated by the BNF Converter (bnfc 2.9.5).

-- Templates for pattern matching on abstract syntax

{-# OPTIONS_GHC -fno-warn-unused-matches #-}

module SkelTreeSitter where

import Prelude (($), Either(..), String, (++), Show, show)
import qualified AbsTreeSitter

type Err = Either String
type Result = Err String

failure :: Show a => a -> Result
failure x = Left $ "Undefined case: " ++ show x

transId :: AbsTreeSitter.Id -> Result
transId x = case x of
  AbsTreeSitter.Id string -> failure x

transGrammar :: AbsTreeSitter.Grammar -> Result
transGrammar x = case x of
  AbsTreeSitter.Grammar preamble grammarbody -> failure x

transPreamble :: AbsTreeSitter.Preamble -> Result
transPreamble x = case x of
  AbsTreeSitter.Preamble constdecls -> failure x

transConstDecl :: AbsTreeSitter.ConstDecl -> Result
transConstDecl x = case x of
  AbsTreeSitter.ConstDecl id string -> failure x

transGrammarBody :: AbsTreeSitter.GrammarBody -> Result
transGrammarBody x = case x of
  AbsTreeSitter.GrammarBody name rules -> failure x

transName :: AbsTreeSitter.Name -> Result
transName x = case x of
  AbsTreeSitter.Name string -> failure x

transRules :: AbsTreeSitter.Rules -> Result
transRules x = case x of
  AbsTreeSitter.Rules rules -> failure x

transRule :: AbsTreeSitter.Rule -> Result
transRule x = case x of
  AbsTreeSitter.Rule id rule -> failure x
  AbsTreeSitter.Choice rules -> failure x
  AbsTreeSitter.Seq rules -> failure x
  AbsTreeSitter.Repeat rule -> failure x
  AbsTreeSitter.Repeat1 rule -> failure x
  AbsTreeSitter.Optional rule -> failure x
  AbsTreeSitter.Symbol id -> failure x
  AbsTreeSitter.Const id -> failure x
  AbsTreeSitter.Literal string -> failure x
  AbsTreeSitter.Regex string -> failure x
