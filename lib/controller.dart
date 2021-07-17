import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AcannieController with ChangeNotifier {
  // 定数
  // 変数
  int get index => _index;
  int _index = 0;

  // 関数
  void test() {
    _index = 3;
    notifyListeners();
  }
}
