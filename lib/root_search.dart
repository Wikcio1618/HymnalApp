import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hymnal_app/search/search_alphabet.dart';
import 'package:hymnal_app/search/search_category.dart';
import 'package:hymnal_app/search/search_keyboard.dart';
import 'package:hymnal_app/search/search_nothing.dart';
import 'package:hymnal_app/search/search_songbook.dart';
import 'package:hymnal_app/services/navigation_song_notifier.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> with SingleTickerProviderStateMixin {
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
    timeDilation = 1.5;
    return Consumer<StateAndSongNotifier>(
        builder: (context, state, child) =>
            Column(children: _buildSearchPageContent(state)));
  }

  List<Widget> _buildSearchPageContent(StateAndSongNotifier state) {
    var builder = [
      Expanded(
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: searchBody[currSearch]),
      ),
      const Divider(color: Color.fromARGB(255, 190, 136, 86)),
    ];
    if (state.isSearchBarVisible) {
      builder.add(const Divider(color: Color.fromARGB(255, 190, 136, 86)));
      builder.add(_buildSearchBox());
      builder.add(const SizedBox(
        height: 3,
      ));
    }
    return builder;
  }

  Widget _buildSearchBox() => Padding(
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
            Hero(
                tag: 'searchBar',
                child: Card(
                  shape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const SearchView();
                      }));
                    },
                    tileColor: const Color.fromARGB(255, 231, 230, 230),
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    leading: const Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 190, 136, 86),
                    ),
                    title: const Text(
                      'Wyszukaj po tytule lub tekście...',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Color.fromARGB(255, 100, 99, 99)),
                    ),
                  ),
                )),
          ],
        ),
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
