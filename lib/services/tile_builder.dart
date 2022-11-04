import 'package:flutter/material.dart';
import 'package:hymnal_app/services/navigation_song_notifier.dart';
import 'package:provider/provider.dart';
import '../model/hymn.dart';

class TileBuilder {
  static Widget customRubricTile(String label, BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 8),
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
        builder: (context, state, child) => ListTile(
          shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.black45)),
          title: Text(hymn.title),
          subtitle: hymn.text.length >= 40
              ? Text(hymn.text.trim().replaceRange(40, null, '..'))
              : Text(hymn.text),
          onTap: () {
            state.changeState(0);
            state.changeSong(hymn);
            // Navigator.of(context).pushNamed('/', arguments: 1); // coming from navigation opt. 1 (will be change when collections are added)
          },
        ),
      );
}
