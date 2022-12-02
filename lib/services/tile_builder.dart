import 'package:flutter/material.dart';
import 'package:hymnal_app/services/navigation_song_notifier.dart';
import 'package:provider/provider.dart';
import '../model/collection.dart';
import '../model/hymn.dart';

class TileBuilder {
  static Widget customRubricTile(String label, BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 8, bottom: 6),
        child: Column(children: [
          const SizedBox(
            height: 30,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom:
                    BorderSide(color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            child: ListTile(
              leading: Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ),
        ]),
      );

  static Widget customLibraryTile(Hymn hymn) => Consumer<StateAndSongNotifier>(
        builder: (context, state, child) => Padding(
          padding: const EdgeInsets.only(left: 8),
          child: ListTile(
            shape: const RoundedRectangleBorder(
                side: BorderSide(color: Colors.black45)),
            title: Text(hymn.title),
            subtitle: hymn.text.length >= 40
                ? Text(hymn.text
                    .replaceAll('/', '')
                    .trim()
                    .replaceRange(40, null, '..')
                    .replaceAll('\n', ' ')
                    .trim()
                    .replaceAll(RegExp(r'\[[\w+]+\]'),
                        '')) // Don't ask :P it removes chords from display
                : Text(hymn.text
                    .replaceAll('/', '')
                    .trim()
                    .replaceAll('\n', ' ')
                    .trim()
                    .replaceAll(RegExp(r'\[[\w+]+\]'), '')
                    .trim()),
            onTap: () {
              state.changeState(0);
              state.changeSong(hymn);
            },
          ),
        ),
      );

  static Widget collectionTile(Collection collection, BuildContext context) =>
      Padding(
        padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
        child: ListTile(
          shape: const RoundedRectangleBorder(
              side: BorderSide(),
              borderRadius: BorderRadius.all(Radius.elliptical(25, 25))),
          title: Text(collection.name),
          trailing: IconButton(
            iconSize: 35,
            icon: const Icon(Icons.my_library_books), // TODO - choose best Icon
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {
              // TODO - Display hymns in new window
            },
          ),
          onTap: () {
            // TODO - Open collection's list of hymns
          },
        ),
      );
}
