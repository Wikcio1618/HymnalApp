import 'enums.dart';

class Hymn {
  final int? id;
  final String title;
  final String text;
  final List<Songbooks>? songbooks;
  final List<Categories>? categories;

  const Hymn(
      {this.id,
      required this.title,
      required this.text,
      this.songbooks,
      this.categories});

  static List<Hymn> hymns = [
    const Hymn(
        title: 'Cudowna boża łaska',
        text: 'twa, zbawiła z grzechów mnie..',
        songbooks: [Songbooks.glosWiary],
        categories: [Categories.radosne]),
    const Hymn(
        title: 'Cudowna boża łaska',
        text: 'twa, zbawiłaa z grzechów mnie..',
        songbooks: [Songbooks.glosWiary],
        categories: [Categories.radosne]),
    const Hymn(
        title: 'Gdy na ten świat',
        text: 'spoglądam wielki Boże',
        songbooks: [Songbooks.glosWiary],
        categories: [Categories.radosne, Categories.szybkie]),
    const Hymn(title: 'Błogo mi', text: 'W Panu wieczny mam dział', songbooks: [
      Songbooks.pielgrzym
    ], categories: [
      Categories.radosne,
      Categories.szybkie,
      Categories.smutne
    ]),
    const Hymn(
        title: 'Błogo mi',
        text: 'W Panu wieczny mam dział',
        songbooks: [Songbooks.pielgrzym],
        categories: [Categories.smutne]),
    const Hymn(
        title: 'Błogo mi',
        text: 'W Panu wieczny mam dział',
        songbooks: [Songbooks.wedrowiec],
        categories: [Categories.radosne, Categories.szybkie]),
    const Hymn(
        title: 'Błogo mi',
        text: 'W Panu wieczny mam dział',
        songbooks: [Songbooks.wedrowiec, Songbooks.glosWiary],
        categories: [Categories.smutne]),
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

  static List<Hymn> getHymnsOfSongbook(int option) {
    Iterator<Hymn> hymns = Hymn.hymns.iterator;
    List<Hymn> hymnsOfSongbook = [];
    while (hymns.moveNext()) {
      if (hymns.current.songbooks!.contains(Songbooks.values[option])) {
        hymnsOfSongbook.add(hymns.current);
      }
    }
    return hymnsOfSongbook;
  }

  static List<Hymn> getHymnsOfCategory(int option) {
    Iterator<Hymn> hymns = Hymn.hymns.iterator;
    List<Hymn> hymnsOfCategory = [];
    while (hymns.moveNext()) {
      if (hymns.current.categories!.contains(Categories.values[option])) {
        hymnsOfCategory.add(hymns.current);
      }
    }
    return hymnsOfCategory;
  }

  static List<Songbooks> getSongbooksSortedAlphabetically() {
    List<Songbooks> valuesCopy = List.from(Songbooks.values);
    valuesCopy.sort(((a, b) => a.toString().compareTo(b.toString())));
    return valuesCopy;
  }

  static List<Categories> getCategoriesSortedAlphabetically() {
    List<Categories> valuesCopy = List.from(Categories.values);
    valuesCopy.sort(((a, b) => a.toString().compareTo(b.toString())));
    return valuesCopy;
  }
}
