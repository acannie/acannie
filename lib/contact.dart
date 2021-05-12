import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'utils.dart';
import 'layout.dart';

// 自己紹介
class Contact extends StatelessWidget {
  List<Map<String, String>> snsAccount = [
    {'imagePath': 'assets/facebook.png', 'snsName': 'Facebook', 'url': ''},
    {'imagePath': 'assets/github.png', 'snsName': 'GitHub', 'url': ''},
    {'imagePath': 'assets/linkedin.png', 'snsName': 'LinkedIn', 'url': ''},
    {'imagePath': 'assets/twitter.png', 'snsName': 'Twitter', 'url': ''},
  ];

  @override
  Widget build(BuildContext context) {
    Widget snsWithLogo(String imagePath, String snsName) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 30.0,
            height: 30.0,
            decoration: new BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
          Layout.sentenceText(snsName),
        ],
      );
    }

    return Container(
      child: Column(
        children: [
          Padding(padding: EdgeInsets.all(30)),
          Layout.titleText('Contact'),
          Padding(padding: EdgeInsets.all(20)),
          for (int i = 0; i < snsAccount.length; i++)
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 30.0,
                      height: 30.0,
                      decoration: new BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(snsAccount[i]['imagePath']!),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    Layout.sentenceText(snsAccount[i]['snsName']!),
                  ],
                ),
                Padding(padding: EdgeInsets.all(20)),
              ],
            ),
          // Layout.historyTable(educationalBackground),
          Padding(padding: EdgeInsets.all(20)),
          // Layout.historyTable(workHistory),
          Padding(padding: EdgeInsets.all(30)),
        ],
      ),
    );
  }
}
