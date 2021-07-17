import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AcannieController with ChangeNotifier {
  // 定数
  // 変数
  List<String> get keywords => _keywords;
  final List<String> _keywords = [
    "イタリア",
    "イギリス",
    "フランス",
  ];

  // 関数
  void test() {
    notifyListeners();
  }
}
