import 'package:flutter/cupertino.dart';

import '../model/hymn.dart';

class StateAndSongNotifier extends ChangeNotifier {
  int currPage = 0;
  Hymn currSong = Hymn.hymns[0];
  bool isAppBarVisible = true;

  void changeSong(Hymn hymn) {
    currSong = hymn;

    notifyListeners();
  }

  void changeState(int state) {
    currPage = state;

    notifyListeners();
  }
}
