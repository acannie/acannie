import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'utils.dart';
import 'layout.dart';

// 自己紹介
class Introduce extends StatelessWidget {
  final List<History> educationalBackground = [
    History(when: "2016年3月", event: "福井県立藤島高等学校 卒業"),
    History(when: "2020年3月", event: "金沢大学理工学域電子情報学類 卒業"),
    History(when: "2022年3月", event: "金沢大学自然科学研究科電子情報科学専攻博士前期課程 卒業予定"),
  ];
  final List<History> workHistory = [
    History(when: "2020年1月", event: "株式会社金沢エンジニアリングシステムズ アルバイト入社"),
    History(when: "2022年4月", event: "ヤフー株式会社 入社予定"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(padding: EdgeInsets.all(30)),
          Layout.titleText("Introduce"),
          Padding(padding: EdgeInsets.all(20)),
          Container(
            width: 300.0,
            alignment: Alignment.center,
            decoration: new BoxDecoration(
              border: Border.all(color: Colors.pink.shade500, width: 5),
            ),
            child: Image(image: AssetImage('assets/acannie.jpg')),
          ),
          Padding(padding: EdgeInsets.all(20)),
          Layout.titleText("名前"),
          Layout.sentenceText("あかね / Akane"),
          Layout.sentenceText("(nickname) Acannie"),
          Layout.sentenceText(Utils().oldness().toString() + "歳"),
          Padding(padding: EdgeInsets.all(20)),
          Layout.titleText("出身"),
          Layout.sentenceText("福井県生まれ。転勤等で北陸3県の県庁所在地をうろうろしました。"),
          Padding(padding: EdgeInsets.all(20)),
          Layout.titleText("経歴"),
          Layout.sentenceText("金沢大学 → 金沢大学大学院 → ヤフー（予定）"),
          Padding(padding: EdgeInsets.all(30)),
        ],
      ),
    );
  }
}
