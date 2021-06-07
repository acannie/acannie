import 'package:flutter/material.dart';

import 'layout.dart';

// 技術的なこと
class Engineering extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(padding: EdgeInsets.all(30)),
          Layout.titleText("Engineering"),
          Padding(padding: EdgeInsets.all(20)),
          Layout.titleText("言語"),
          Layout.sentenceText("C, C++, Python, VBA, Dart (普段遣い)"),
          Layout.sentenceText("Java, JavaScript (経験あり)"),
          Padding(padding: EdgeInsets.all(20)),
          Layout.titleText("フレームワーク"),
          Layout.sentenceText("Flutter (普段遣い)"),
          Layout.sentenceText("React (経験あり)"),
          Padding(padding: EdgeInsets.all(20)),
          Layout.titleText("ソフトウェア"),
          Layout.sentenceText("Visual Studio Code, PostgreSQL, STK (普段遣い)"),
          Layout.sentenceText("Adobe Photoshop, Adobe After Effects (経験あり)"),
          Padding(padding: EdgeInsets.all(20)),
          Layout.titleText("OS"),
          Layout.sentenceText("Windows10, Linux(Ubuntu, CentOS)"),
          Padding(padding: EdgeInsets.all(30)),
        ],
      ),
    );
  }
}
