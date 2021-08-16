import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'introduce.dart';
import 'contact.dart';
import 'works.dart';
import 'engineering.dart';
import 'favorite.dart';
import 'layout.dart';
import 'terminal.dart';

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

// Terminal Content
class TerminalContent {
  String title;
  Widget content;

  TerminalContent({
    required this.title,
    required this.content,
  });
}

class AcannieController with ChangeNotifier {
  // *********************************
  // * コンストラクタ                 *
  // *********************************

  AcannieController() {
    _selectedPageContents = pageContents;
  }

  // *********************************
  // * 定数                          *
  // *********************************

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

  List<TerminalContent> terminalContents = [
    TerminalContent(
      title: "TERMINAL",
      content: Terminal(),
    ),
    TerminalContent(
      title: "DEBUG CONSOLE",
      content: Text("Coming Soon!", style: TextStyle(color: Colors.white)),
    ),
    TerminalContent(
        title: "PROBLEMS",
        content: Text("Coming Soon!", style: TextStyle(color: Colors.white))),
    TerminalContent(
        title: "OUTPUT",
        content: Text("Coming Soon!", style: TextStyle(color: Colors.white))),
  ];

  // *********************************
  // * 変数                          *
  // *********************************

  int get activePageIndex => _activePageIndex;
  int _activePageIndex = 0;

  // 左側のリストが表示モードになっているか
  bool get leftListActive => _leftListActive;
  bool _leftListActive = true;

  // 左側のバーの中でアクティブになっているアイコンのindex
  int get activeLeftBarIconIndex => _activeLeftBarIconIndex;
  int _activeLeftBarIconIndex = 0;

  List<PageContent>? get selectedPageContents => _selectedPageContents;
  List<PageContent>? _selectedPageContents;

  // Terminal が表示モードか
  bool get terminalActive => _terminalActive;
  bool _terminalActive = false;

  // WSL モードか否（PowerShellモード）か
  bool get wslMode => _wslMode;
  bool _wslMode = true;

  // *********************************
  // * Private 関数                   *
  // *********************************

  // *********************************
  // * Public 関数                   *
  // *********************************

  void setActivePage(int pageIndex) {
    _activePageIndex = pageIndex;
    notifyListeners();
  }

  void tapLeftBarIcon(int index) {
    // 選択されているアイコンをクリックした場合
    if (_leftListActive == true && index == _activeLeftBarIconIndex) {
      _leftListActive = false;
      notifyListeners();
      return;
    }
    _leftListActive = true;
    _activeLeftBarIconIndex = index;
    notifyListeners();
  }

  void switchTerminalActivity() {
    _terminalActive = !_terminalActive;
    notifyListeners();
  }

  // WSL モードと PowerShell モードを切り替え
  void switchWslMode() {
    _wslMode = !_wslMode;
    notifyListeners();
  }
}
