import 'package:flutter/material.dart';
import 'package:hymnal_app/search/search_alphabet.dart';
import 'package:hymnal_app/search/search_category.dart';
import 'package:hymnal_app/search/search_nothing.dart';
import 'package:hymnal_app/search/search_songbook.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  static List<Widget> searchBody = const [
    AlphabeticalListView(),
    SongbookMenu(),
    CategoryMenu(),
    NoSearchYet(),
  ];
  int currSearch = searchBody.length - 1;
  final List<bool> selected =
      List.generate(searchBody.length, (index) => false);

  @override
  Widget build(BuildContext context) {
    return _customSearchContainer();
  }

  Widget _customSearchContainer() => Column(
        children: [
/*             const Divider(
              color: Colors.black,
              height: 20,
            ), */
          Expanded(
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: searchBody[currSearch])),
          const Divider(color: Color.fromARGB(255, 190, 136, 86)),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, right: 25, left: 25),
            child: Column(
              children: [
                Row(
                  children: [
                    _customSearchOutlinedButton('Alfabetycznie', 0),
                    const SizedBox(width: 5),
                    _customSearchOutlinedButton('Śpiewniki', 1),
                    const SizedBox(width: 5),
                    _customSearchOutlinedButton('Kategorie', 2),
                  ],
                ),
                ListTile(
                  tileColor: const Color.fromARGB(255, 231, 230, 230),
                  shape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  leading: const Icon(Icons.search),
                  title: TextField(
                    autocorrect: false,
                    // autofocus: true,
                    onTap: () {
                      onSearchOptionTap(3);
                    },
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Wyszukaj po tytule lub tekście...',
                        hintStyle: TextStyle(fontStyle: FontStyle.italic)),
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
              ],
            ),
          ),
        ],
      );

  Widget _customSearchOutlinedButton(String label, int index) => OutlinedButton(
        onPressed: () {
          onSearchOptionTap(index);
          FocusScope.of(context).requestFocus(FocusNode());
        },
        style: ButtonStyle(
            backgroundColor: selected[index]
                ? const MaterialStatePropertyAll(
                    Color.fromARGB(255, 231, 230, 230))
                : null,
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)))),
        child: Text(label),
      );

  onSearchOptionTap(int index) {
    setState(() {
      selected.setAll(
          0, List.generate(searchBody.length - 1, (index) => false));
      selected[index] = true;
      currSearch = index;
    });
  }
}
