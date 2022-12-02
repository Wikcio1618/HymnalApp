import 'package:flutter/material.dart';
import 'package:flutter_chord/flutter_chord.dart';

import 'package:hymnal_app/services/navigation_song_notifier.dart';
import 'package:provider/provider.dart';

class Song extends StatefulWidget {
  const Song({super.key});

  @override
  State<Song> createState() => _SongState();
}

class _SongState extends State<Song> {
  bool showChord = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<StateAndSongNotifier>(builder: (context, state, child) {
      return Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: LyricsRenderer(
              widgetPadding: 20,
              showChord: showChord,
              lyrics: state.currSong != null ? state.currSong!.text : 'no',
              textStyle: const TextStyle(color: Colors.black, fontSize: 16),
              chordStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              onTapChord: (String chord) {
                // TODO - (2nd priority) add tooltip with chord picture
              }));
    });
  }
}
