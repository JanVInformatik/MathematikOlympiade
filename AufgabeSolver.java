public class AufgabeSolver {
  public static void main(String[] args) {
    // Durchlaufe alle möglichen Werte für a, b, c, d und e
    for (int a = 1; a < 10; a++) {
      for (int b = a + 1; b < 10; b++) {
        for (int c = b + 1; c < 10; c++) {
          for (int d = c + 1; d < 10; d++) {
            for (int e = d + 1; e < 10; e++) {
              // Berechne die linke Seite der Gleichung: a^e
              int leftSide = (int) Math.pow(a, e);

              // Berechne die rechte Seite der Gleichung: (b * d + 1) * c
              int rightSide = (b * d + 1) * c;

              // Prüfen, ob die Gleichung erfüllt ist
              if (leftSide == rightSide) {
                System.out
                    .println("Lösung gefunden: a = " + a + ", b = " + b + ", c = " + c + ", d = " + d + ", e = " + e);
              }
            }
          }
        }
      }
    }
  }
}
