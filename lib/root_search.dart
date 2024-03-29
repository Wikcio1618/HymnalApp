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
      builder: (context, state, child) => Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: _buildSearchPageContent(state, context)),
    );
  }

  List<Widget> _buildSearchPageContent(
      StateAndSongNotifier state, BuildContext context) {
    List<Widget> builder = [
      Flexible(
        child: SizedBox(height: double.infinity, child: searchBody[currSearch]),
      )
    ];
    if (state.isSearchBarVisible) {
      builder.add(_buildSearchBox(context));
    }
    return builder;
  }

  Widget _buildSearchBox(BuildContext context) {
    return ClipRRect(
      child: Container(
        padding: const EdgeInsets.only(bottom: 10, right: 15, left: 15),
        margin: const EdgeInsets.only(top: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, -1.0), //(x,y)
              blurRadius: 6.0,
            )
          ],
        ),
        child: Column(children: [
          // const Divider(),
          Row(
            children: [
              const SizedBox(width: 5),
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
                    return const KeyboardSearch();
                  }));
                },
                tileColor: const Color.fromARGB(255, 231, 230, 230),
                shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                leading: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text(
                  'Wyszukaj po tytule lub tekście...',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Color.fromARGB(255, 100, 99, 99)),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }

  Widget _customSearchOutlinedButton(String label, int index) => OutlinedButton(
        onPressed: () {
          onSearchOptionTap(index);
          // FocusScope.of(context).requestFocus(FocusNode());
        },
        style: ButtonStyle(
          backgroundColor: selected[index]
              ? const MaterialStatePropertyAll(
                  Color.fromARGB(255, 231, 230, 230))
              : null,
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),
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
