haskell-coffee
==============

A simple library to use the CoffeeScript compiler with Haskell Bindings

Installation
------------
```
cabal install haskell-coffee
```

Usage
-----
```
data Coffee = Coffee
    { customCompiler :: Maybe FilePath -- ^ Custom compiler path, set to Nothing for default
    , bare :: Bool                     -- ^ set True to use '-b' option.
    }
```

```
-- | Compile .coffee file(s)
coffeeCompile :: [FilePath]     -- ^ List of .coffee files to compile
              -> Maybe FilePath -- ^ Output directory, Nothing for default
              -> Coffee         -- ^ Coffee structure for more options
              -> IO ExitCode    -- ^ Exit code

```

```
-- | Get the version of the coffee binary
coffeeVersion :: Coffee -> IO String
coffeeVersion c = coffeeRead c ["-v"]
```

```
-- | Print the coffee output
coffeePrint :: FilePath -> Coffee -> IO String
coffeePrint file c = coffeeRead c $ ["-v", file]
```


Example
-------

Results in "/path/to/script.coffee" and "/path/to/script2.coffee" to be compiled
and outputted to "/my/output/path/"

```
myCoffee = Coffee (Just "/usr/local/bin/coffee") False

files = ["/path/to/script.coffee","/path/to/script2.coffee"]

main = coffeeCompile files (Just "/my/output/path/") myCoffee
```
