import 'package:flutter/cupertino.dart';

import '../model/hymn.dart';

class StateAndSongNotifier extends ChangeNotifier {
  int currState = 0;
  Hymn currSong = Hymn.hymns[0];

  void changeSong(Hymn hymn) {
    currSong = hymn;
    notifyListeners();
  }

  void changeState(int state) {
    currState = state;
    notifyListeners();
  }
}
