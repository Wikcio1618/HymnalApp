import 'package:flutter/cupertino.dart';

class StateNotifier extends ChangeNotifier {
  int currState = 0;

  void changeState(int state) {
    currState = state;
    notifyListeners();
  }
}
