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

  static Future<void> fetchHymns() async {
/*     await db
        .collection('hymns')
        .get()
        .then((value) => print(value.docs), onError: (e) => throw Exception(e)); */
/*     await FirebaseFirestore.instance.collection('/hymns').get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
      }
    }, onError: (e) => throw Exception(e)); */

    final ref = db
        .collection("hymns")
        .doc("V1Gdf7DdyT0J3YDoxJrJ")
        .withConverter<Hymn>(
            fromFirestore: Hymn.fromFirestore,
            toFirestore: (Hymn hymn, _) => hymn.toFirestore());
    await ref.get().then((value) {
      hymns.add(value.data()!);
      print(value.data());
    }, onError: (e) {
      throw Exception(e);
    });

/*     db
        .collection("hymns")
        .get()
        .then((value) => print('Successfully fetched!')); */
  }

  factory Hymn.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Hymn(
      title: data?['title'],
      text: data?['text'],
      votes: data?['votes'],
      songbooks:
          data?['songbooks'] is Iterable ? List.from(data?['songbooks']) : null,
      categories: data?['categories'] is Iterable
          ? List.from(data?['categories'])
          : null,
    );
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
