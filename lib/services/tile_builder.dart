import 'package:flutter/material.dart';
import 'package:hymnal_app/collections_collection.dart';
import 'package:hymnal_app/services/navigation_song_notifier.dart';
import 'package:provider/provider.dart';
import '../model/collection.dart';
import '../model/hymn.dart';

class TileBuilder {
  static Widget rubricTile(Pattern label, BuildContext context) => Padding(
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
            // How to override tile color theme?? might cause problems later
            child: ListTile(
                tileColor: Theme.of(context).scaffoldBackgroundColor,
                shape: RoundedRectangleBorder(side: BorderSide.none),
                leading: Text(
                  // Regexp to string has its pattern on 17th character
                  label.toString().substring(17, 18),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                )),
          ),
        ]),
      );

  static Widget customHymnTile(Hymn hymn) => Consumer<StateAndSongNotifier>(
        builder: (context, state, child) => Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 4),
          child: ListTile(
            title: Text(
              hymn.title,
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
            subtitle: hymn.text.length >= 40
                ? Text(
                    hymn.text
                        .replaceAll('/', '')
                        .trim()
                        .replaceRange(40, null, '..')
                        .replaceAll('\n', ' ')
                        .trim()
                        // Don't ask :P it removes chords from display
                        .replaceAll(RegExp(r'\[[\w+]+\]'), ''),
                  )
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

  static Widget customCollectionTile(
          Collection collection, BuildContext context) =>
      Padding(
        padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
        child: ListTile(
          shape: RoundedRectangleBorder(
            side: BorderSide(
                color: Theme.of(context).colorScheme.secondary, width: 2),
          ),
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
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => InspectCollection(nameKey: collection.key),
            ));
          },
        ),
      );
}
