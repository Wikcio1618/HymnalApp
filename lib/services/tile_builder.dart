import 'package:flutter/material.dart';
import 'package:hymnal_app/services/navigation_song_notifier.dart';
import 'package:provider/provider.dart';
import '../model/hymn.dart';

class TileBuilder {
  static Widget customRubricTile(String label) => Column(children: [
        const SizedBox(
          height: 30,
        ),
        Container(
          decoration: const BoxDecoration(
              border: Border(
                  bottom:
                      BorderSide(color: Color.fromARGB(255, 231, 230, 230)))),
          child: ListTile(
            leading: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: Color.fromARGB(255, 190, 136, 86),
              ),
            ),
          ),
        ),
      ]);

  static Widget customLibraryTile(Hymn hymn) => Consumer<StateAndSongNotifier>(
        builder: (context, state, child) => ListTile(
          title: Text(hymn.title),
          subtitle: Text(hymn.text),
          onTap: () {
            state.changeState(0);
            state.changeSong(hymn);
            // Navigator.of(context).pushNamed('/', arguments: 1); // coming from navigation opt. 1 (will be change when collections are added)
          },
        ),
      );
}
