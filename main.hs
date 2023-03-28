import System.Clock (Clock(Monotonic), getTime, toNanoSecs)
import Control.Monad (forM_, when)
import System.IO (stdout, hPutStrLn, hFlush, withFile, IOMode(..), Handle)
import System.Directory (doesFileExist, removeFile)

main :: IO ()
main = do
  let a = 2 ^ 24 -- 2^24
      b = 2 ^ 25 -- 2^25
      fileName = "./float/haskell.txt"

  withBufferedWriter fileName $ \bufferedWriter -> do
    hSetBuffering stdout NoBuffering
    putStrLn $ "a = " ++ show a
    putStrLn $ "b = " ++ show b

    startTime <- getTime Monotonic
    let printProgress n c = do
          let n' = fromIntegral (100 * (c - a)) `div` (b - a)
          when (n' /= n) $ putStrLn $ show n' ++ "/100"
          pure n'

    forM_ [a..b] $ \c -> do
      let s = printf "c = %08d => %8.1f\n" c (fromIntegral c :: Float)
      hPutStr bufferedWriter s

      n <- printProgress n c

    stopTime <- getTime Monotonic
    let elapsedTime = fromIntegral (toNanoSecs (stopTime - startTime)) / 1000000
    putStrLn $ show elapsedTime ++ "ms"

  fileExists <- doesFileExist fileName
  when fileExists $ removeFile fileName


withBufferedWriter :: FilePath -> (Handle -> IO a) -> IO a
withBufferedWriter fileName f = do
  fileExists <- doesFileExist fileName
  when fileExists $ removeFile fileName
  withFile fileName WriteMode f
