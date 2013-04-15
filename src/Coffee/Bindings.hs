-- | A simple Cofeescript library.

module Coffee.Bindings
       ( Coffee(..)
       , coffeeCompile
       , coffeeVersion
       , coffeePrint
       ) where

import Data.Maybe (fromMaybe)
import System.Process (rawSystem, readProcess)
import System.Exit (ExitCode)

-- | The Coffee data structure
data Coffee = Coffee
    { customCompiler :: Maybe FilePath -- ^ Custom compiler path, set to Nothing for default
    , bare :: Bool                     -- ^ set True to use '-b' option.
    }

-- | Compile .coffee file(s)
coffeeCompile :: [FilePath]     -- ^ List of .coffee files to compile
              -> Maybe FilePath -- ^ Output directory, Nothing for default
              -> Coffee         -- ^ Coffee structure for more options
              -> IO ExitCode    -- ^ Exit code
coffeeCompile files output coffee =
    rawSystem (getCompiler coffee) args
  where args = outputPath output ++ ["-c"] ++ files

-- | Get the version of the coffee binary
coffeeVersion :: Coffee -> IO String
coffeeVersion c = coffeeRead c ["-v"]

-- | Print the coffee output
coffeePrint :: FilePath -> Coffee -> IO String
coffeePrint file c = coffeeRead c $ ["-v", file]

outputPath :: Maybe FilePath -> [FilePath]
outputPath (Just path) = ["-o", path]
outputPath Nothing     = []

getCompiler :: Coffee -> FilePath
getCompiler = fromMaybe "coffee" . customCompiler

coffeeRead :: Coffee -> [String] -> IO String
coffeeRead coffee args =
    readProcess (getCompiler coffee) args []
