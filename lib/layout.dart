import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  static Widget historyTable(List<Map<String, String>> history) {
    return Column(
      children: <Widget>[
        for (int i = 0; i < history.length; i++)
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  history[i]["when"]!,
                  style: TextStyle(
                    color: contentChar,
                    fontSize: 20,
                  ),
                ),
                Text(
                  history[i]["event"]!,
                  style: TextStyle(
                    color: contentChar,
                    fontSize: 20,
                  ),
                ),
                // Flexible(
                //   flex: 1,
                //   child: Container(
                //     color: Colors.blue,
                //     child: Text('Flexible\n\n(flex:1)'),
                //   ),
                // ),
              ],
            ),
          ),
      ],
    );
  }
}
