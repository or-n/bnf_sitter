-- -*- haskell -*- File generated by the BNF Converter (bnfc 2.9.5).

-- Parser definition for use with Happy
{
{-# OPTIONS_GHC -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
{-# LANGUAGE PatternSynonyms #-}

module ParTreeSitter
  ( happyError
  , myLexer
  , pTreeSitterGrammar
  ) where

import Prelude

import qualified AbsTreeSitter
import LexTreeSitter

}

%name pTreeSitterGrammar TreeSitterGrammar
-- no lexer declaration
%monad { Err } { (>>=) } { return }
%tokentype {Token}
%token
  '$'         { PT _ (TS _ 1)  }
  '('         { PT _ (TS _ 2)  }
  ')'         { PT _ (TS _ 3)  }
  ','         { PT _ (TS _ 4)  }
  '.'         { PT _ (TS _ 5)  }
  ':'         { PT _ (TS _ 6)  }
  ';'         { PT _ (TS _ 7)  }
  '='         { PT _ (TS _ 8)  }
  '=>'        { PT _ (TS _ 9)  }
  'RustRegex' { PT _ (TS _ 10) }
  'choice'    { PT _ (TS _ 11) }
  'const'     { PT _ (TS _ 12) }
  'exports'   { PT _ (TS _ 13) }
  'grammar'   { PT _ (TS _ 14) }
  'module'    { PT _ (TS _ 15) }
  'name'      { PT _ (TS _ 16) }
  'new'       { PT _ (TS _ 17) }
  'repeat'    { PT _ (TS _ 18) }
  'rules'     { PT _ (TS _ 19) }
  'seq'       { PT _ (TS _ 20) }
  '{'         { PT _ (TS _ 21) }
  '}'         { PT _ (TS _ 22) }
  L_quoted    { PT _ (TL $$)   }
  L_Id        { PT _ (T_Id $$) }

%%

String  :: { String }
String   : L_quoted { $1 }

Id :: { AbsTreeSitter.Id }
Id  : L_Id { AbsTreeSitter.Id $1 }

TreeSitterGrammar :: { AbsTreeSitter.TreeSitterGrammar }
TreeSitterGrammar
  : Preamble 'module' '.' 'exports' '=' 'grammar' '(' '{' GrammarBody '}' ')' ';' { AbsTreeSitter.TreeSitterGrammar $1 $9 }

Preamble :: { AbsTreeSitter.Preamble }
Preamble : ListConstDecl { AbsTreeSitter.Preamble $1 }

ConstDecl :: { AbsTreeSitter.ConstDecl }
ConstDecl : 'const' Id '=' String { AbsTreeSitter.ConstDecl $2 $4 }

ListConstDecl :: { [AbsTreeSitter.ConstDecl] }
ListConstDecl
  : {- empty -} { [] } | ConstDecl ';' ListConstDecl { (:) $1 $3 }

GrammarBody :: { AbsTreeSitter.GrammarBody }
GrammarBody
  : Name ',' Rules ',' { AbsTreeSitter.GrammarBody $1 $3 }

Name :: { AbsTreeSitter.Name }
Name : 'name' ':' String { AbsTreeSitter.Name $3 }

Rules :: { AbsTreeSitter.Rules }
Rules : 'rules' ':' '{' ListRule '}' { AbsTreeSitter.Rules $4 }

Rule :: { AbsTreeSitter.Rule }
Rule : Id ':' '$' '=>' Expression { AbsTreeSitter.Rule $1 $5 }

ListRule :: { [AbsTreeSitter.Rule] }
ListRule : {- empty -} { [] } | Rule ',' ListRule { (:) $1 $3 }

Expression :: { AbsTreeSitter.Expression }
Expression
  : 'choice' '(' ListExpression ')' { AbsTreeSitter.Choice $3 }
  | 'seq' '(' ListExpression ')' { AbsTreeSitter.Seq $3 }
  | 'repeat' '(' Expression ')' { AbsTreeSitter.Repeat $3 }
  | '$' '.' Id { AbsTreeSitter.Symbol $3 }
  | Id { AbsTreeSitter.Const $1 }
  | String { AbsTreeSitter.Literal $1 }
  | 'new' 'RustRegex' '(' String ')' { AbsTreeSitter.Regex $4 }

ListExpression :: { [AbsTreeSitter.Expression] }
ListExpression
  : {- empty -} { [] }
  | Expression { (:[]) $1 }
  | Expression ',' ListExpression { (:) $1 $3 }

{

type Err = Either String

happyError :: [Token] -> Err a
happyError ts = Left $
  "syntax error at " ++ tokenPos ts ++
  case ts of
    []      -> []
    [Err _] -> " due to lexer error"
    t:_     -> " before `" ++ (prToken t) ++ "'"

myLexer :: String -> [Token]
myLexer = tokens

}

