enum Songbooks { pielgrzym, wedrowiec, glosWiary }

extension SongbooksExtension on Songbooks {
  String get name {
    switch (this) {
      case Songbooks.pielgrzym:
        return "Pielgrzym";
      case Songbooks.wedrowiec:
        return "Wędrowiec";
      case Songbooks.glosWiary:
        return "Głos Wiary";
    }
  }
}

enum Categories { radosne, smutne, szybkie }

extension CategoriesExtension on Categories {
  String get name {
    switch (this) {
      case Categories.radosne:
        return "Radosne";
      case Categories.smutne:
        return "Smutne";
      case Categories.szybkie:
        return "Szybkie";
    }
  }
}
