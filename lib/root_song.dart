import 'package:flutter/cupertino.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:hymnal_app/services/navigation_song_notifier.dart';
import 'package:provider/provider.dart';

class Song extends StatefulWidget {
  const Song({super.key});

  @override
  State<Song> createState() => _SongState();
}

class _SongState extends State<Song> {
  int check = 1;

  @override
  Widget build(BuildContext context) {
    return Consumer<StateAndSongNotifier>(builder: (context, state, child) {
      return state.currSong == null
          ? const Text('Nie wybrano pieśni')
          : const TeXView(
              child: TeXViewDocument(r"""<h2>Flutter \( \rm\\TeX \)</h2>"""));

      /* Center(child: Text(notifier.currSong.title)); */
    });
  }
}
