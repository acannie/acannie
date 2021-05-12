import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'utils.dart';
import 'layout.dart';

// 自己紹介
class Contact extends StatelessWidget {
  List<Map<String, String>> snsAccounts = [
    {
      'imagePath': 'assets/facebook.png',
      'name': 'Facebook',
      'url': 'https://www.facebook.com/made.in.akane'
    },
    {
      'imagePath': 'assets/github.png',
      'name': 'GitHub',
      'url': 'https://github.com/acannie'
    },
    {
      'imagePath': 'assets/linkedin.png',
      'name': 'LinkedIn',
      'url': 'https://www.linkedin.com/in/akane-sasaoka/'
    },
    {
      'imagePath': 'assets/twitter.png',
      'name': 'Twitter',
      'url': 'https://twitter.com/CO_KEISAN_SKILL'
    },
  ];

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
          for (var snsAccount in snsAccounts)
            Column(
              children: [
                InkWell(
                  onTap: () => _launchURL(snsAccount['url']!),
                  child: snsWithLogo(
                    snsAccount['imagePath']!,
                    snsAccount['name']!,
                  ),
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
