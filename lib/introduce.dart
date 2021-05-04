import 'dart:ui';

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
    return Container(
      child: Column(
        children: [
          Padding(padding: EdgeInsets.all(30)),
          Text("Introduce"),
          Padding(padding: EdgeInsets.all(20)),
          Container(
            width: 300.0,
            height: 300.0,
            alignment: Alignment.center,
            decoration: new BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/acannie.jpg'),
                fit: BoxFit.fill,
              ),
              border: Border.all(color: Colors.pink.shade500, width: 5),
            ),
          ),
          Padding(padding: EdgeInsets.all(20)),
          Layout.titleText("名前"),
          Layout.sentenceText("笹岡 茜 / Sasaoka Akane"),
          Layout.sentenceText(Utils().oldness().toString() + "歳"),
          Padding(padding: EdgeInsets.all(20)),
          Layout.titleText("出身"),
          Layout.sentenceText("北陸生まれの北陸育ちです。"),
          Padding(padding: EdgeInsets.all(20)),
          Layout.titleText("学歴"),
          Layout().historyTable(educationalBackground),
          Padding(padding: EdgeInsets.all(20)),
          Layout.titleText("職歴"),
          Layout().historyTable(workHistory),
          Padding(padding: EdgeInsets.all(30)),
        ],
      ),
    );
  }
}
