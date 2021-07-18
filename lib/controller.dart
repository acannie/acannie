import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'introduce.dart';
import 'contact.dart';
import 'works.dart';
import 'engineering.dart';
import 'favorite.dart';

// Page
class PageContent {
  IconData iconData;
  Color iconColor;
  String title;
  Widget content;
  int lineLength;

  PageContent({
    required this.iconData,
    required this.iconColor,
    required this.title,
    required this.content,
    required this.lineLength,
  });
}

class AcannieController with ChangeNotifier {
  // 定数
  List<PageContent> pageContents = [
    PageContent(
      iconData: Icons.sentiment_satisfied_outlined,
      iconColor: Color.fromARGB(255, 81, 154, 186),
      title: "Introduce",
      content: Introduce(),
      lineLength: 43,
    ),
    PageContent(
      iconData: Icons.contact_mail,
      iconColor: Color.fromARGB(255, 160, 116, 196),
      title: "Contact",
      content: Contact(),
      lineLength: 21,
    ),
    PageContent(
      iconData: Icons.palette,
      iconColor: Color.fromARGB(255, 227, 121, 51),
      title: "Works",
      content: Works(),
      lineLength: 29,
    ),
    PageContent(
      iconData: Icons.computer,
      iconColor: Color.fromARGB(255, 81, 154, 186),
      title: "Engineering",
      content: Engineering(),
      lineLength: 34,
    ),
    PageContent(
      iconData: Icons.favorite,
      iconColor: Color.fromARGB(255, 204, 62, 68),
      title: "Favorite",
      content: Favorite(),
      lineLength: 11,
    ),
  ];

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
