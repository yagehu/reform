module Main where

import Prelude hiding (Down)

import Options.Applicative

main :: IO ()
main = do
  config <- execParser parser
  run config
  where
    parser :: ParserInfo Config
    parser = info
      (   helper
      <*> infoOption "0.1.0" (long "version" <> help "Print version.")
      <*>
        (   Config
        <$> hsubparser (upCommand <> downCommand)
        )
      )
      (fullDesc <> progDesc "Reform - provision infrastrucuture statelessly.")
    upCommand :: Mod CommandFields Command
    upCommand = command "up"
      ( info (pure Up) (progDesc "Provision resources.")
      )
    downCommand :: Mod CommandFields Command
    downCommand = command "down"
      ( info (pure Down) (progDesc "Destroy resources.")
      )

newtype Config = Config
  { cmd :: Command
  }

data Command
  = Up
  | Down

run :: Config -> IO ()
run (Config Up) = putStrLn "Up called"
run (Config Down) = putStrLn "Down called"
