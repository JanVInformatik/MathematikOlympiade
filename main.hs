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

-- Hauptfunktion zum Nullenerzeugen
generateNulls :: MS.MultiSet Int -> Int -> Int
generateNulls tafel nullenCount
  | nullenCount >= 5 = nullenCount
  | MS.size tafel < 2 = nullenCount
  | otherwise =
      let (a, b, sumAB, diffAB) = applyOperation tafel
          newTafel = MS.delete a (MS.delete b tafel)
          updatedTafel =
            if diffAB == 0
              then MS.insert sumAB (MS.insert 0 newTafel)
              else MS.insert sumAB (MS.insert diffAB newTafel)
          newNullenCount = if diffAB == 0 then nullenCount + 1 else nullenCount
       in generateNulls updatedTafel newNullenCount

-- Hauptprogramm
main :: IO ()
main = do
  let maxNullen = generateNulls initialTafel 0
  putStrLn $ "Maximale Anzahl an Nullen erzeugt: " ++ show maxNullen
