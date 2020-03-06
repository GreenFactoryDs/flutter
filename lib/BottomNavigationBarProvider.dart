
import 'package:flutter/cupertino.dart';

class BottomNavigationBarProvider with ChangeNotifier{
  int _currentIdx = 0;

  int get currentIdx => _currentIdx;

  set currentIdx(int value) {
    _currentIdx = value;
    notifyListeners();
  }


}