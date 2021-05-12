import 'package:flutter/material.dart';

import 'layout.dart';

// 作品紹介
class Works extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(padding: EdgeInsets.all(30)),
          Layout.titleText("Works"),
          Layout.sentenceText("Coming Soon!"),
        ],
      ),
    );
  }
}
