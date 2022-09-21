import 'package:flutter/material.dart';
import 'package:hymnal_app/services/tile_builder.dart';

import '../model/hymn.dart';

class AlphabeticalListView extends StatefulWidget {
  const AlphabeticalListView({super.key});

  @override
  State<AlphabeticalListView> createState() => _AlphabeticalListViewState();
}

class _AlphabeticalListViewState extends State<AlphabeticalListView> {
  final hymnsSorted = Hymn.sortHymnsAlphabetically();

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
    'Z',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _customColumnChildren(),
    );
  }

  List<Widget> _customColumnChildren() {
    Iterator<String> letterIterator = letters.iterator;
    List<Widget> columnChildren = [];
    columnChildren.add(TileBuilder.customRubricTile(letters[0]));
    letterIterator.moveNext();

/*     bool matchingTitle = (hymnIterator != hymnsSorted.length)
        ? hymnsSorted[hymnIterator]
            .title
            .toLowerCase()
            .startsWith(letters[letterIterator].toLowerCase())
        : false; */

    while (letterIterator.moveNext()) {
      Iterator<Hymn> hymnIterator = hymnsSorted.iterator;
      columnChildren.add(TileBuilder.customRubricTile(letterIterator.current));
      while (hymnIterator.moveNext()) {
        if (hymnIterator.current.title
            .toLowerCase()
            .startsWith(letterIterator.current.toLowerCase())) {
          columnChildren
              .add(TileBuilder.customLibraryTile(hymnIterator.current));
        }
      }
    }
    return columnChildren;
  }
}
