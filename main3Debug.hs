import Data.List (find)
import Data.Maybe (fromMaybe)
import Data.MultiSet qualified as MS

-- Anfangs-Tafel
initialTafel :: MS.MultiSet Int
initialTafel = MS.fromList [1, 2, 3, 4, 5, 6]

-- Funktion zur gezielten Nullenerzeugung
generateNulls :: MS.MultiSet Int -> Int -> IO Int
generateNulls tafel nullenCount
  | nullenCount >= 5 = do
      putStrLn $ "Maximale Anzahl an Nullen erreicht: " ++ show nullenCount
      return nullenCount
  | MS.size tafel < 2 = do
      putStrLn "Nicht genügend Zahlen für weitere Operationen."
      return nullenCount
  | otherwise = do
      -- Suche nach einer Zahl mit mindestens zwei Vorkommen
      let sameNumber = find (\x -> MS.occur x tafel >= 2) (MS.toList tafel)

      case sameNumber of
        Just x -> do
          -- Wenn mindestens zwei gleiche Zahlen x vorhanden sind, führe die Operation aus
          let updatedTafel = MS.insert (2 * x) (MS.delete x (MS.delete x tafel))
          let newNullenCount = nullenCount + 1
          putStrLn $ "Zwei gleiche Zahlen " ++ show x ++ " gewählt, Null erzeugt."
          putStrLn $ "Aktuelle Tafel nach Operation: " ++ show (MS.toList updatedTafel)
          putStrLn $ "Anzahl erzeugter Nullen: " ++ show newNullenCount
          putStrLn "-------------------------------------------"
          generateNulls updatedTafel newNullenCount
        Nothing -> do
          -- Wenn keine zwei gleichen Zahlen vorhanden sind, wähle die zwei kleinsten
          let (a, b) = getTwoSmallest tafel
          let sumAB = a + b
          let diffAB = 2 * abs (a - b)
          let newTafel = MS.delete a (MS.delete b tafel)
          let updatedTafel =
                if diffAB == 0
                  then MS.insert sumAB (MS.insert 0 newTafel)
                  else MS.insert sumAB (MS.insert diffAB newTafel)
          let newNullenCount = if diffAB == 0 then nullenCount + 1 else nullenCount
          putStrLn $ "Zwei kleinste Zahlen gewählt: " ++ show a ++ ", " ++ show b
          putStrLn $ "Summe: " ++ show sumAB ++ ", Doppelte Differenz: " ++ show diffAB
          putStrLn $ "Aktuelle Tafel nach Operation: " ++ show (MS.toList updatedTafel)
          putStrLn $ "Anzahl erzeugter Nullen: " ++ show newNullenCount
          putStrLn "-------------------------------------------"
          generateNulls updatedTafel newNullenCount

-- Funktion zum Abrufen der zwei kleinsten Elemente
getTwoSmallest :: MS.MultiSet Int -> (Int, Int)
getTwoSmallest ms =
  let (a, rest) = MS.deleteFindMin ms
      (b, _) = MS.deleteFindMin rest
   in (a, b)

-- Hauptprogramm
main :: IO ()
main = do
  maxNullen <- generateNulls initialTafel 0
  putStrLn $ "Maximale Anzahl an Nullen erzeugt: " ++ show maxNullen
