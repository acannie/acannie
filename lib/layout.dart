import 'package:flutter/material.dart';

class History {
  String when;
  String event;

  History({required this.when, required this.event});
}

// レイアウト
class Layout {
  static const Color appBarBg = Color.fromARGB(255, 60, 60, 60);
  static const Color appBarLabel = Color.fromARGB(255, 200, 200, 200);
  static const Color leftBarBg = Color.fromARGB(255, 51, 51, 51);
  static const Color bottomBarRemoteBg = Color.fromARGB(255, 22, 130, 93);
  static const Color bottomBarMainBg = Color.fromARGB(255, 0, 122, 204);
  static const Color tabBarActiveBg = Color.fromARGB(255, 30, 30, 30);
  static const Color tabBarNonActiveBg = Color.fromARGB(255, 45, 45, 45);
  static const Color tabBarActiveLabel = Color.fromARGB(255, 255, 255, 255);
  static const Color tabBarNonActiveLabel = Color.fromARGB(255, 150, 150, 150);
  static const Color tabBarBg = Color.fromARGB(255, 37, 37, 38);
  static const Color lineIndexNonActiveLabel =
      Color.fromARGB(255, 133, 133, 133);
  static const Color contentChar = Color.fromARGB(255, 212, 212, 212);

  // ファイルリスト関連
  static const Color fileListLabel = Color.fromARGB(255, 204, 204, 204);
  static const Color fileListBg = Color.fromARGB(255, 37, 37, 38);
  static const Color fileListActiveLabel = Color.fromARGB(255, 255, 255, 255);
  static const Color fileListNonActiveLabel =
      Color.fromARGB(255, 133, 133, 133);

  // Terminal 関連
  static const Color terminalBorder = Color.fromARGB(255, 65, 65, 65);
  static const Color terminalTabBarActiveLabel =
      Color.fromARGB(255, 231, 231, 231);
  static const Color terminalTabBarNonActiveLabel =
      Color.fromARGB(255, 151, 151, 151);
  static const Color terminalIconButton = Color.fromARGB(255, 197, 197, 197);
  static const Color terminalCurrentPath = Color.fromARGB(255, 55, 131, 214);
  static const Color terminalMachineName = Color.fromARGB(255, 34, 195, 130);
  static const Color terminalStdInput = Color.fromARGB(255, 204, 204, 204);

  static Text titleText(String title) {
    return Text(
      title,
      style: TextStyle(
        color: contentChar,
        fontWeight: FontWeight.bold,
        fontSize: 40,
      ),
    );
  }

  static Text sentenceText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: contentChar,
        fontSize: 20,
      ),
    );
  }

  static Widget historyTable(List<History> histories) {
    return Container(
      // width: 500,
      child: Table(
        columnWidths: const <int, TableColumnWidth>{
          0: IntrinsicColumnWidth(),
          1: FlexColumnWidth(),
        },
        children: <TableRow>[
          for (History history in histories)
            TableRow(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  // flex: 1,
                  child: Text(
                    history.when,
                    style: TextStyle(
                      color: contentChar,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(child: Text("  ")),
                Container(
                  alignment: Alignment.centerLeft,
                  // flex: 5,
                  child: Text(
                    history.event,
                    style: TextStyle(
                      color: contentChar,
                      fontSize: 20,
                    ),
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
