extension BidiUtils on int {
  bool get isLatin => (this >= 48 && this <= 57) || (this >= 65 && this <= 90) || (this >= 97 && this <= 122);
  bool get isHebrew => (this >= 1425 && this <= 1524) || (this >= 1536 && this <= 1791) || (this >= 65165 && this <= 65276);
  bool get isNeutral => !isLatin && !isHebrew;
}

extension Bidi on String {
   String bidi() {
    List<int> original = this.codeUnits;
    List<int> latin = [];
    List<int> hebrew = [];
    List<int> neutral = [];
    for (int char in original) {
      /*--------HEBREW-----------*/

      if (char.isHebrew) {
        if (latin.isNotEmpty) {
          hebrew.insertAll(0, latin);
          latin.clear();
        }
        if (neutral.isNotEmpty) {
          hebrew.insertAll(0, neutral.reversed);
          neutral.clear();
        }
        hebrew.insert(0, char);
      }

      /*--------LATIN-----------*/

      if (char.isLatin) {
        if (neutral.isNotEmpty) {
          hebrew.isEmpty || hebrew.first.isHebrew ? hebrew.insertAll(0, neutral.reversed) : latin.addAll(neutral);

          neutral.clear();
        }
        latin.add(char);
      }

      /*--------NEUTRAL-----------*/

      if (char.isNeutral) {
        neutral.add(char);
      }
    }
    hebrew.insertAll(0, neutral.reversed);
    hebrew.insertAll(0, latin);

    return String.fromCharCodes(hebrew);
  }
}