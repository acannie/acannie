import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AcannieController with ChangeNotifier {
  // 定数
  // 変数
  int get activePageIndex => _activePageIndex;
  int _activePageIndex = 0;

  bool get pageListSelected => _pageListSelected;
  bool _pageListSelected = false;

  List<String> get contents => _contents;
  List<String> _contents = [
    "Introduce",
    "Contact",
    "Works",
    "Engineering",
    "Favorite",
  ];

  // 関数
  void setActivePage(int pageIndex) {
    _activePageIndex = pageIndex;
    notifyListeners();
  }

  void selectFileList() {
    _pageListSelected = !_pageListSelected;
    notifyListeners();
  }
}
