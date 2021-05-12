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
          Layout.sentenceText("Coming Soon!"),
        ],
      ),
    );
  }
}
