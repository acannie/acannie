import 'package:flutter/material.dart';

import 'layout.dart';

// 作品紹介
class Favorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(padding: EdgeInsets.all(30)),
          Layout.titleText("Favorite"),
          Layout.sentenceText("Coming Soon!"),
        ],
      ),
    );
  }
}
