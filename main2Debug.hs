import Data.List (minimumBy)
import Data.MultiSet qualified as MS
import Data.Ord (comparing)

-- Anfangs-Tafel
initialTafel :: MS.MultiSet Int
initialTafel = MS.fromList [1, 2, 3, 4, 5, 6]

-- Funktion zum Anwenden der Operation
applyOperation :: MS.MultiSet Int -> (Int, Int, Int, Int)
applyOperation tafel =
  let (a, b) = getTwoSmallest tafel
      sumAB = a + b
      diffAB = 2 * abs (a - b)
   in (a, b, sumAB, diffAB)

-- Funktion zum Abrufen der zwei kleinsten Elemente
getTwoSmallest :: MS.MultiSet Int -> (Int, Int)
getTwoSmallest ms =
  let (a, rest) = MS.deleteFindMin ms
      (b, _) = MS.deleteFindMin rest
   in (a, b)

-- Hauptfunktion zum Nullenerzeugen mit Debug-Prints
generateNulls :: MS.MultiSet Int -> Int -> IO Int
generateNulls tafel nullenCount
  | nullenCount >= 5 = do
      putStrLn $ "Maximale Anzahl an Nullen erreicht: " ++ show nullenCount
      return nullenCount
  | MS.size tafel < 2 = do
      putStrLn "Nicht genügend Zahlen für weitere Operationen."
      return nullenCount
  | otherwise = do
      let (a, b, sumAB, diffAB) = applyOperation tafel
      let newTafel = MS.delete a (MS.delete b tafel)
      let updatedTafel =
            if diffAB == 0
              then MS.insert sumAB (MS.insert 0 newTafel)
              else MS.insert sumAB (MS.insert diffAB newTafel)
      let newNullenCount = if diffAB == 0 then nullenCount + 1 else nullenCount

      -- Debug-Ausgaben
      putStrLn $ "Zwei kleinste Zahlen gewählt: " ++ show a ++ ", " ++ show b
      putStrLn $ "Summe: " ++ show sumAB ++ ", Doppelte Differenz: " ++ show diffAB
      putStrLn $ "Aktuelle Tafel nach Operation: " ++ show (MS.toList updatedTafel)
      putStrLn $ "Anzahl erzeugter Nullen: " ++ show newNullenCount
      putStrLn "-------------------------------------------"

      generateNulls updatedTafel newNullenCount

-- Hauptprogramm
main :: IO ()
main = do
  maxNullen <- generateNulls initialTafel 0
  putStrLn $ "Maximale Anzahl an Nullen erzeugt: " ++ show maxNullen
