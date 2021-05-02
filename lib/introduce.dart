import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'utils.dart';
import 'layout.dart';

// 自己紹介
class Introduce extends StatelessWidget {
  List<Map<String, String>> educationalBackground = [
    {"when": "2016年3月", "event": "福井県立藤島高等学校 卒業"},
    {"when": "2020年3月", "event": "金沢大学理工学域電子情報学類 卒業"},
    {"when": "2022年3月", "event": "金沢大学自然科学研究科電子情報科学専攻博士前期課程 卒業予定"},
  ];
  List<Map<String, String>> workHistory = [
    {"when": "2020年1月", "event": "株式会社金沢エンジニアリングシステムズ 入社"},
    {"when": "2022年4月", "event": "ヤフー株式会社 入社予定"},
  ];

  @override
  Widget build(BuildContext context) {
    Layout layout = Layout();
    return SingleChildScrollView(
      // child: Center(
      child: Row(children: [
        Column(children: [
          for (var i = 0; i < 50; i++)
            Text("${i + 1}",
                textAlign: TextAlign.right,
                style: TextStyle(
                    color: Color.fromARGB(255, 133, 133, 133), fontSize: 15)),
        ]),
        // Text(
        //   "aas\nb\nfga\nbjg\nl\nj\nk\nn\na\ne\nl\nkrj\n lia\n jerla\njlk\nfnak\nlnv\nalknglknsg\n\nl\n\naaaa",
        //   style: TextStyle(color: Colors.white, fontSize: 50),
        // ),
      ]),

      // Padding(padding: EdgeInsets.all(30)),
      // Text("Introduce"),
      // Padding(padding: EdgeInsets.all(20)),
      // Container(
      //   width: 300.0,
      //   height: 300.0,
      //   alignment: Alignment.center,
      //   decoration: new BoxDecoration(
      //     image: DecorationImage(
      //       image: AssetImage('acannie.jpg'),
      //       fit: BoxFit.fill,
      //     ),
      //     border: Border.all(color: Colors.pink.shade500, width: 5),
      //   ),
      // ),
      // Padding(padding: EdgeInsets.all(20)),
      // layout.titleText("名前"),
      // Text("笹岡 茜 / Sasaoka Akane"),
      // Text(Utils().oldness().toString() + "歳"),
      // Padding(padding: EdgeInsets.all(20)),
      // layout.titleText("出身"),
      // Text("北陸生まれの北陸育ちです。"),
      // Padding(padding: EdgeInsets.all(20)),
      // layout.titleText("学歴"),
      // layout.historyTable(educationalBackground),
      // Padding(padding: EdgeInsets.all(20)),
      // layout.titleText("職歴"),
      // layout.historyTable(workHistory),
      // Padding(padding: EdgeInsets.all(30)),

      // ),
    );
  }
}
