class TextFormatter {
  static String formatList(List<String> items, String testName) {
    return items.map((item) => '$testName = $item').join('\n');
  }

  static String prepareText(List<String> items) {
    int half = items.length ~/ 2; // Делим список пополам
    String fermatPart = formatList(items.sublist(0, half), 'Тест Ферма c a');
    String millerRabinPart =
        formatList(items.sublist(half), 'Тест Миллера-Робина c a');
    return "$fermatPart\n$millerRabinPart";
  }
}
