import 'package:flutter/material.dart';
import 'package:hymnal_app/search_alphabet.dart';
import 'package:hymnal_app/search_category.dart';
import 'package:hymnal_app/search_nothing.dart';
import 'package:hymnal_app/search_songbook.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  static List<Widget> searchBody = const [
    AlphabeticalListView(),
    SongbookListView(),
    CategoryListView(),
    NoSearchYet(),
  ];
  int currSearch = searchBody.length - 1;
  final List<bool> selected =
      List.generate(searchBody.length - 1, (index) => false);

  @override
  Widget build(BuildContext context) {
    return _customSearchContainer();
  }

  Widget _customSearchContainer() => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 25, left: 25),
            child: Column(children: [
              const ListTile(
                tileColor: Color.fromARGB(255, 231, 230, 230),
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                leading: Icon(Icons.search),
                title: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Wyszukaj po tytule lub tekście...',
                      hintStyle: TextStyle(fontStyle: FontStyle.italic)),
                ),
              ),
              Row(
                children: [
                  _customSearchOutlinedButton('Alfabetycznie', 0),
                  const SizedBox(width: 5),
                  _customSearchOutlinedButton('Śpiewniki', 1),
                  const SizedBox(width: 5),
                  _customSearchOutlinedButton('Kategorie', 2),
                ],
              )
            ]),
          ),
          searchBody[currSearch],
        ],
      );

  Widget _customSearchOutlinedButton(String label, int index) => OutlinedButton(
      onPressed: () {
        setState(() {
          selected.setAll(
              0, List.generate(searchBody.length - 1, (index) => false));
          selected[index] = true;
          currSearch = index;
        });
      },
      style: ButtonStyle(
          backgroundColor: selected[index]
              ? const MaterialStatePropertyAll<Color>(Color.fromARGB(255, 231, 230, 230))
              : null,
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
      child: Text(label));

/*  

  Widget _onAlphabeticalOptionChosen() {
    return AlphabetListScrollView(strList: Hymn.getTitles(), indexedHeight: (i) => 80,);
  }

  List<Widget> _libraryListTiles(List<Hymn> hymns) {
    List<Widget> viewTiles = [];
    for (var hymn in hymns) {
      viewTiles.add(ListTile(
        title: Text(hymn.title),
        subtitle: Text(hymn.text),
      ));
    }
    return viewTiles;
  } */
}
