import 'package:flutter/material.dart';
import 'package:hymnal_app/services/tile_builder.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

import '../model/hymn.dart';

class AlphabeticalListView extends StatefulWidget {
  const AlphabeticalListView({super.key});

  @override
  State<AlphabeticalListView> createState() => _AlphabeticalListViewState();
}

class _AlphabeticalListViewState extends State<AlphabeticalListView> {
  final _letterScrollController = ItemScrollController();
  final _wheelScrollController = FixedExtentScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();

  final hymnsSorted = Hymn.sortHymnsAlphabetically();

  final List<String> letters = [
    'A',
    'B',
    'C',
    'Ć',
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
    'Ó',
    'P',
    'R',
    'S',
    'Ś',
    'T',
    'U',
    'W',
    'Y',
    'Z',
    'Ź',
    'Ż',
    '#'
  ];

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Flexible(
        child: ScrollablePositionedList.builder(
          itemScrollController: _letterScrollController,
          itemPositionsListener: _itemPositionsListener,
          itemCount: letters.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(children: _buildRubricColumn(index));
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 5),
        child: WheelChooser(
          perspective: 0.005,
          magnification: 1.2,
          listHeight: 400,
          listWidth: 40,
          selectTextStyle:
              TextStyle(color: Theme.of(context).colorScheme.secondary),
          unSelectTextStyle:
              TextStyle(color: Theme.of(context).colorScheme.secondary),
          startPosition: 0,
          onValueChanged: (letter) =>
              _scrollListToLetter(letters.indexOf(letter)),
          datas: letters,
        ),
      ),
    ]);
  }

  void _scrollListToLetter(int letter) {
    // TODO - adjust the animation for UX
    _letterScrollController.scrollTo(
        index: letter,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutQuad);
  }

  void notifyWheel() {
    var positions = _itemPositionsListener.itemPositions.value;
    int? min;
    if (positions.isNotEmpty) {
      // Determine the first visible item by finding the item with the
      // smallest trailing edge that is greater than 0.  i.e. the first
      // item whose trailing edge in visible in the viewport.
      min = positions
          .where((ItemPosition position) => position.itemTrailingEdge > 0)
          .reduce((ItemPosition min, ItemPosition position) =>
              position.itemTrailingEdge < min.itemTrailingEdge ? position : min)
          .index;
      _wheelScrollController.jumpToItem(min);
    }
  }

/*   void _scrollWheelToLetter(int letter) {
    _wheelScrollController.animateToItem(letter,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutQuad);
  } */
// Couldn't implement that well

  List<Widget> _buildRubricColumn(int letter) {
    List<Widget> column = [
      TileBuilder.customRubricTile(letters[letter], context)
    ];
    if (letters[letter] != '#') {
      for (var hymn in hymnsSorted) {
        if (hymn.title[0].toLowerCase() == letters[letter].toLowerCase()) {
          column.add(TileBuilder.customLibraryTile(hymn));
        }
      }
    } else {
      for (var hymn in hymnsSorted) {
        if (hymn.title
            .toLowerCase()
            .startsWith(RegExp(r'[^\w]ąćóńśźż', caseSensitive: false))) {
          column.add(TileBuilder.customLibraryTile(hymn));
        }
      }
    }
    return column;
  }
}
