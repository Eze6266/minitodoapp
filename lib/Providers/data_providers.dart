import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  int seldataType = 0;
  int seldataPlan = 0;

  callDataNotifier() {
    notifyListeners();
  }
}
