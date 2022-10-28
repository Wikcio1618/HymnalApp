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
/*   @override
  void initState() {
    super.initState();
    _itemPositionsListener.itemPositions.addListener(notifyWheel);
  }

  @override
  void dispose() {
    _itemPositionsListener.itemPositions
        .removeListener(notifyWheel);
    super.dispose();
  } */

  final _letterScrollController = ItemScrollController();
  final _wheelScrollController = FixedExtentScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();

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
              {_scrollListToLetter(letters.indexOf(letter))},
          datas: letters,
        ),
      ),
    ]);
  }

  void _scrollListToLetter(int letter) {
    _letterScrollController.scrollTo(
        index: letter,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutQuad);
  }

  void notifyWheel() {
    var positions = _itemPositionsListener.itemPositions.value;
    // _letterScrollController.itemPositionsNotifier
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

  void _scrollWheelToLetter(int letter) {
    _wheelScrollController.animateToItem(letter,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutQuad);
  }

  /* Widget _buildListeningWheel() =>
      ValueListenableBuilder<Iterable<ItemPosition>>(
        valueListenable: _itemPositionsListener.itemPositions,
        builder: (context, positions, child) {
          int? min;
          if (positions.isNotEmpty) {
            // Determine the first visible item by finding the item with the
            // smallest trailing edge that is greater than 0.  i.e. the first
            // item whose trailing edge in visible in the viewport.
            min = positions
                .where((ItemPosition position) => position.itemTrailingEdge > 0)
                .reduce((ItemPosition min, ItemPosition position) =>
                    position.itemTrailingEdge < min.itemTrailingEdge
                        ? position
                        : min)
                .index;
          }
          return WheelChooser(
            perspective: 0.005,
            magnification: 1.2,
            listHeight: 400,
            listWidth: 40,
            selectTextStyle:
                const TextStyle(color: Color.fromARGB(255, 190, 136, 86)),
            unSelectTextStyle:
                const TextStyle(color: Color.fromARGB(255, 187, 139, 95)),
            startPosition: min,
            controller: null,
            onValueChanged: (letter) =>
                {_scrollListToLetter(letters.indexOf(letter))},
            datas: letters,
          );
        },
      );
 */
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
        if (hymn.title.toLowerCase().startsWith(RegExp(r'[^a-z]'))) {
          column.add(TileBuilder.customLibraryTile(hymn));
        }
      }
    }
    return column;
  }

// Changed for builder of 24 columns
  /*  List<Widget> _customColumnChildren() {
    Iterator<String> letterIterator = letters.iterator;
    List<Widget> columnChildren = [];
    columnChildren.add(TileBuilder.customRubricTile(letters[0]));
    letterIterator.moveNext();

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
  } */
}

/* class customWheel extends WheelChooser {
  final Key key;
  const customWheel({@required key});

  @override
  State<customWheel> createState() => _customWheelState();
}

class _customWheelState extends State<customWheel> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
} */
