import 'package:flutter/cupertino.dart';

import '../model/hymn.dart';

class SongNotifier extends ChangeNotifier {
  Hymn? currSong;

  void changeSong(Hymn hymn) {
    currSong = hymn;
    notifyListeners();
  }
}
