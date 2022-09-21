import 'dart:ui';

import 'package:flutter/material.dart';

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

  Color get color {
    switch (this) {
      case Categories.radosne:
        return const Color.fromARGB(255, 225, 154, 149);
      case Categories.smutne:
        return const Color.fromARGB(255, 142, 188, 226);
      case Categories.szybkie:
        return const Color.fromARGB(255, 233, 224, 145);
    }
  }
}
