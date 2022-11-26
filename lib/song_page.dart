import 'package:flutter/material.dart';
import 'package:flutter_chord/flutter_chord.dart';
import 'package:hymnal_app/services/navigation_song_notifier.dart';
import 'package:provider/provider.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<StateAndSongNotifier>(
        builder: (context, state, child) => Column(children: [
          Container(),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(30),
                child: LyricsRenderer(
                    lyrics:
                        state.currSong != null ? state.currSong!.text : 'no',
                    textStyle:
                        const TextStyle(color: Colors.black, fontSize: 16),
                    chordStyle:
                        const TextStyle(color: Colors.black, fontSize: 16),
                    onTapChord: (String chord) {}),
              ),
              Positioned(
                left: 30,
                top: 30,
                child: IconButton(
                  icon: const Icon(Icons.arrow_downward),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
