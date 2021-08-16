import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'layout.dart';
import 'utils.dart';

// 作品紹介
class Works extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(padding: EdgeInsets.all(30)),
          Layout.titleText("Works"),
          Padding(padding: EdgeInsets.all(20)),

          // AC MyDesigner
          InkWell(
            child: Wrap(
              children: [
                Layout.titleText("AC MyDesigner"),
                Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                Icon(Icons.launch, color: Layout.contentChar),
              ],
            ),
            onTap: () =>
                {Utils.launchURL("https://acannie.github.io/ac_mydesigner/")},
          ),
          Layout.sentenceText("人気ゲーム「あつまれどうぶつの森」のマイデザイン作成補助サービスです。"),
          Layout.sentenceText("画像をマイデザインに変換します。"),
          Padding(padding: EdgeInsets.all(20)),

          // Emoji Art Maker
          InkWell(
            child: Wrap(
              children: [
                Layout.titleText("Emoji Art Maker"),
                Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                Icon(Icons.launch, color: Layout.contentChar),
              ],
            ),
            onTap: () =>
                {Utils.launchURL("https://acannie.github.io/emoji_art_maker/")},
          ),
          Layout.sentenceText("画像を9色の絵文字"),
          Layout.sentenceText("🟥🟧🟨🟩🟦🟪🟫⬛⬜"),
          Layout.sentenceText("で表現したアートに変換するサービスです。"),
          Padding(padding: EdgeInsets.all(20)),

          // JOHINKODICE
          InkWell(
            child: Wrap(
              children: [
                Layout.titleText("JOHINKODICE"),
                Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                Icon(Icons.launch, color: Layout.contentChar),
              ],
            ),
            onTap: () =>
                {Utils.launchURL("https://acannie.github.io/johinkodice/")},
          ),
          Layout.sentenceText("サイコロを投げて単語を揃えて楽しむという、"),
          Layout.sentenceText("非常に上品なゲームを楽しめるサービスです。"),
          Padding(padding: EdgeInsets.all(30)),
        ],
      ),
    );
  }
}
