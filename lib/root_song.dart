import 'package:flutter/cupertino.dart';
import 'package:hymnal_app/services/state_song_notifier.dart';
import 'package:provider/provider.dart';

class Song extends StatelessWidget {
  const Song({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StateAndSongNotifier>(builder: (context, notifier, child) {
      return Center(child: Text(notifier.currSong.title));
    });
  }
}
