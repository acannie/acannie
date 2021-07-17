import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AcannieController with ChangeNotifier {
  // 定数
  // 変数
  int get activePageIndex => _activePageIndex;
  int _activePageIndex = 0;

  bool get pageListSelected => _pageListSelected;
  bool _pageListSelected = true;

  // 関数
  void test() {
    _activePageIndex = 3;
    notifyListeners();
  }

  void selectFileList() {
    _pageListSelected = !_pageListSelected;
    notifyListeners();
  }
}
