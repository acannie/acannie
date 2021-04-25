import 'package:flutter/material.dart';

import 'introduce.dart';
import 'contact.dart';
import 'works.dart';
import 'favorite.dart';

// ページ全体のレイアウトを生成
class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  static List<Map<String, dynamic>> contents = [
    {
      "icon": Icon(Icons.sentiment_satisfied_outlined),
      "title": Text("Introduce"),
      "content": Introduce(),
    },
    {
      "icon": Icon(Icons.contact_mail),
      "title": Text("Contact"),
      "content": Contact(),
    },
    {
      "icon": Icon(Icons.palette),
      "title": Text("Works"),
      "content": Works(),
    },
    {
      "icon": Icon(Icons.favorite),
      "title": Text("Favorite"),
      "content": Favorite(),
    },
  ];

  AppBar appBarMain() {
    return AppBar(
      title: const Text('Acannie\'s HomePage'),
      backgroundColor: Colors.pink.shade200,
      bottom: TabBar(
        isScrollable: true,
        indicatorColor: Colors.pink.shade400,
        mouseCursor: SystemMouseCursors.click,
        tabs: <Tab>[
          for (int i = 0; i < contents.length; i++)
            Tab(
              icon: Row(
                children: <Widget>[
                  contents[i]["icon"],
                  Padding(padding: EdgeInsets.all(10)),
                  contents[i]["title"],
                ],
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: contents.length,
      child: Scaffold(
        appBar: appBarMain(),
        body: TabBarView(
          children: <Widget>[
            for (int i = 0; i < contents.length; i++) contents[i]["content"]
          ],
        ),
        backgroundColor: Colors.pink.shade50,
      ),
    );
  }
}
