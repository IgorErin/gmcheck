{-|
Module      : Builtin
Description : Built-in GML functions

Types of built-in instance variables and signatures of library functions.
-}

module Language.GML.Checker.Builtin where

import qualified Data.Text.IO as T (readFile)
import Text.Megaparsec (errorBundlePretty) 

import System.IO.Unsafe

import Language.GML.Parser.Types

unsafeLoad parser file = unsafePerformIO $ do
    src <- T.readFile file
    case parser file src of
        Left err -> error $ errorBundlePretty err
        Right res -> return res

builtinVar :: VarDict
builtinVar = unsafeLoad parseVars "data/instance_var.ty"

builtinFn :: FunDict
builtinFn = unsafeLoad parseFun "data/functions.ty"