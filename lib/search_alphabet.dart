import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'model/hymn.dart';

class AlphabeticalListView extends StatefulWidget {
  const AlphabeticalListView({super.key});

  @override
  State<AlphabeticalListView> createState() => _AlphabeticalListViewState();
}

class _AlphabeticalListViewState extends State<AlphabeticalListView> {
  final hymnsSorted = Hymn.sortHymnsAlphabetically();
  int hymnIterator = 0;
  int letterIterator = 0;

  final List<String> letters = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'R',
    'S',
    'T',
    'U',
    'W',
    'Y',
    'Z'
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      itemBuilder: itemBuilder,
      itemCount: hymnsSorted.length + letters.length,
    ));
  }

  Widget itemBuilder(context, index) {
    if (hymnIterator == hymnsSorted.length) {
      hymnIterator = 0;
    }
    if (letterIterator == letters.length) {
      letterIterator = 0;
    }

    if (index == 0) {
      return _customLetterTile(letters[letterIterator]);
    }

    bool matchingTitle = (hymnIterator != hymnsSorted.length)
        ? hymnsSorted[hymnIterator]
            .title
            .toLowerCase()
            .startsWith(letters[letterIterator].toLowerCase())
        : false;

    if (matchingTitle) {
      hymnIterator++;
      return _customLibraryTile(hymnsSorted[hymnIterator - 1]);
    } else {
      letterIterator++;
      return _customLetterTile(letters[letterIterator - 1]);
    }
  }

  Widget _customLetterTile(String letter) => ListTile(
        leading: Text(
          letter,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color.fromARGB(255, 190, 136, 86),
          ),
        ),
      );

  Widget _customLibraryTile(Hymn hymn) => ListTile(
        title: Text(hymn.title),
        subtitle: Text(hymn.text),
      );
}
