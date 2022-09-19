import 'enums.dart';

class Hymn {
  final int? id;
  final String title;
  final String text;
  final List<Songbooks>? songbook;
  final List<Categories>? category;

  const Hymn(
      {this.id,
      required this.title,
      required this.text,
      this.songbook,
      this.category});

  static List<Hymn> hymns = [
    const Hymn(
        title: 'Cudowna boża łaska',
        text: 'twa, zbawiła z grzechów mnie..',
        songbook: [Songbooks.glosWiary],
        category: [Categories.radosne]),
    const Hymn(
        title: 'Cudowna boża łaska',
        text: 'twa, zbawiłaa z grzechów mnie..',
        songbook: [Songbooks.glosWiary],
        category: [Categories.radosne]),
    const Hymn(
        title: 'Gdy na ten świat',
        text: 'spoglądam wielki Boże',
        songbook: [Songbooks.glosWiary],
        category: [Categories.radosne, Categories.szybkie]),
    const Hymn(
        title: 'Błogo mi',
        text: 'W Panu wieczny mam dział',
        songbook: [Songbooks.pielgrzym],
        category: [Categories.radosne, Categories.szybkie, Categories.smutne]),
    const Hymn(
        title: 'Błogo mi',
        text: 'W Panu wieczny mam dział',
        songbook: [Songbooks.pielgrzym],
        category: [Categories.smutne]),
    const Hymn(
        title: 'Błogo mi',
        text: 'W Panu wieczny mam dział',
        songbook: [Songbooks.wedrowiec],
        category: [Categories.radosne, Categories.szybkie]),
    const Hymn(
        title: 'Błogo mi',
        text: 'W Panu wieczny mam dział',
        songbook: [Songbooks.wedrowiec, Songbooks.glosWiary],
        category: [Categories.smutne]),
  ];

  static List<String> getTitles() {
    List<String> titles = [];
    for (var hymn in hymns) {
      titles.add(hymn.title);
    }
    return titles;
  }

  static List<Hymn> sortHymnsAlphabetically() {
    List<Hymn> hymnsCopy = List.from(hymns);
    hymnsCopy.sort(((hymn1, hymn2) => hymn1.title.compareTo(hymn2.title)));
    return hymnsCopy;
  }
}
