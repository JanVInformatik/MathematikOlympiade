#include <cmath>
#include <iostream>
#include <set>
#include <vector>

int main() {
  // Die anfänglichen Zahlen auf der Tafel
  std::multiset<int> tafel = {1, 2, 3, 4, 5, 6};
  int nullen = 0;

  while (tafel.size() > 1) {
    // Prüfen, ob wir genügend gleiche Zahlen für eine gezielte Paarung haben
    auto it = tafel.begin();
    std::vector<int> gleicheZahlen;

    // Zähle Häufigkeit der ersten Zahl
    int zahl = *it;
    gleicheZahlen.push_back(zahl);

    for (auto it2 = std::next(it); it2 != tafel.end() && *it2 == zahl; ++it2) {
      gleicheZahlen.push_back(*it2);
    }

    if (gleicheZahlen.size() >= 2) {
      // Wenn mindestens zwei gleiche Zahlen vorhanden sind, Paarung zur
      // Erzeugung einer Null
      tafel.erase(tafel.find(zahl));
      tafel.erase(tafel.find(zahl));
      tafel.insert(zahl + zahl); // Summe hinzufügen
      tafel.insert(0);           // Null hinzufügen
      nullen++;
    } else {
      // Wenn keine gleiche Paarung möglich ist, verwenden wir die zwei
      // kleinsten Elemente
      auto it1 = tafel.begin();
      int a = *it1;
      tafel.erase(it1);

      auto it2 = tafel.begin();
      int b = *it2;
      tafel.erase(it2);

      // Berechne a + b und 2 * |a - b|
      int sum = a + b;
      int diff = 2 * std::abs(a - b);

      tafel.insert(sum);
      tafel.insert(diff);
    }

    // Abbruchbedingung, wenn wir bereits 5 Nullen erzeugt haben
    if (nullen >= 5) {
      break;
    }

    // Aktuelle Tafel ausgeben
    std::cout << "Aktuelle Tafel: ";
    for (int zahl : tafel) {
      std::cout << zahl << " ";
    }
    std::cout << std::endl;
  }

  // Maximale Anzahl an Nullen ausgeben
  std::cout << "Maximale Anzahl an Nullen erzeugt: " << nullen << std::endl;
  return 0;
}
