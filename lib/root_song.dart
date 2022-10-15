import 'package:flutter/cupertino.dart';
import 'package:hymnal_app/services/navigation_song_notifier.dart';
import 'package:provider/provider.dart';

class Song extends StatefulWidget {
  const Song({super.key});

  @override
  State<Song> createState() => _SongState();
}

class _SongState extends State<Song> {
  @override
  Widget build(BuildContext context) {
    return Consumer<StateAndSongNotifier>(builder: (context, notifier, child) {
      return Center(
          child: notifier.currSong == null
              ? const Text("Nie wybrano pieśni")
              : Text(notifier.currSong!.text));
    });
  }
}
