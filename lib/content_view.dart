import 'dart:ui';

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import 'utils.dart';
import 'layout.dart';

// 自己紹介
class ContentView extends StatelessWidget {
  final Widget? content;
  ContentView(this.content);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                for (var i = 0; i < 100; i++)
                  Container(
                    width: 40,
                    padding: EdgeInsets.only(top: 2, left: 20, bottom: 2),
                    color: Layout.tabBarActiveBg,
                    child: Text(
                      "${i + 1}",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Layout.lineIndexNonActiveLabel,
                        fontSize: 15,
                        fontFeatures: [
                          FontFeature.tabularFigures(),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            Expanded(child: this.content!),
          ],
        )
      ],
    );
  }
}
