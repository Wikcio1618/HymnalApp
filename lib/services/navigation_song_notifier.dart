import 'package:flutter/cupertino.dart';

import '../model/hymn.dart';

class StateAndSongNotifier extends ChangeNotifier {
  int currPage = 0;
  Hymn? currSong;
  bool isAppBarVisible = true;
  int? categoryState;
  bool isSearchBarVisible = true;

  void changeSong(Hymn hymn) {
    currSong = hymn;
    notifyListeners();
  }

  void changeState(int state) {
    currPage = state;
    notifyListeners();
  }

  void changeCategoryState(int val) {
    categoryState = val;
    notifyListeners();
  }

  void changeAppBarVisibility(bool val) {
    isAppBarVisible = val;
    notifyListeners();
  }

  void changeSearchBarVisibility(bool val) {
    isSearchBarVisible = val;
    notifyListeners();
  }
}
