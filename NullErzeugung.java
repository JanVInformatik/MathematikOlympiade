import java.util.TreeSet;

public class NullErzeugungEffizient {

  public static void main(String[] args) {
    TreeSet<Integer> tafel = new TreeSet<>();
    // Anfangszahlen auf die Tafel setzen
    tafel.add(1);
    tafel.add(2);
    tafel.add(3);
    tafel.add(4);
    tafel.add(5);
    tafel.add(6);

    int nullen = 0;

    while (tafel.size() > 1) {
      // Holen der zwei kleinsten Elemente
      int a = tafel.pollFirst();
      int b = tafel.pollFirst();

      // Berechne a + b und 2 * |a - b|
      int sum = a + b;
      int diff = 2 * Math.abs(a - b);

      // Wenn 2 * |a - b| == 0, Null erzeugt
      if (diff == 0) {
        tafel.add(sum); // Summe zurück in die Tafel
        tafel.add(0); // Null einfügen
        nullen++;
      } else {
        // Ansonsten: Summe und Differenz hinzufügen
        tafel.add(sum);
        tafel.add(diff);
      }

      // Aktuellen Zustand der Tafel ausgeben
      System.out.println("Aktuelle Tafel: " + tafel);
    }

    // Ausgabe der maximalen Anzahl erzeugter Nullen
    System.out.println("Maximale Anzahl an Nullen erzeugt: " + nullen);
  }
}
