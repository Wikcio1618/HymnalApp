import 'package:cloud_firestore/cloud_firestore.dart';
import 'enums.dart';

class Hymn {
  String title;
  String text;
  int? votes;
  List<Songbooks>? songbooks;
  List<Categories>? categories;

  Hymn(
      {required this.title,
      required this.text,
      this.votes,
      this.songbooks,
      this.categories});

  static final db = FirebaseFirestore.instance;
  static List<Hymn> hymns = [];

  static Future<void> fetchHymns() async {}

  factory Hymn.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Hymn(
      title: data?['title'],
      text: data?['text'],
      votes: data?['votes'],
      songbooks: List.generate(data?['songbooks'].length,
          (index) => Songbooks.values[data?['songbooks'][index]]),
      categories: List.generate(
          data?['songbooks'].length, (index) => Categories.values[index]),
    );
    // TODO - implement prevention from number greater than enum length
  }

  Map<String, dynamic> toFirestore() {
    return {
      "title": title,
      "text": text,
      if (votes != null) "votes": votes,
      if (songbooks != null) "songbooks": songbooks,
      if (categories != null) "categories": categories,
    };
  }

  List<String> getTitles() {
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
