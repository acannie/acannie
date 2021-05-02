import 'package:flutter/material.dart';

import 'layout.dart';
import 'introduce.dart';
import 'contact.dart';
import 'works.dart';
import 'favorite.dart';

// ページ全体のレイアウトを生成
class BarWidgetClass {
  PreferredSize appBarMain() {
    return PreferredSize(
      preferredSize: Size.fromHeight(30.0),
      child: AppBar(
        title: Row(
          children: [
            Flexible(
              child: Container(
                child: Image.asset("assets/wn_icon.png"),
                width: 30,
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 20)),
            Text(
              'Acannie\'s HomePage',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Layout.appBarLabel,
                fontSize: 20,
              ),
            )
          ],
        ),
        backgroundColor: Layout.appBarBg,
        elevation: 0,
      ),
    );
  }

  Widget tabBar() {
    List<Map<String, dynamic>> contents = [
      {
        "icon": Icon(
          Icons.sentiment_satisfied_outlined,
          color: Color.fromARGB(255, 81, 154, 186),
          size: 15,
        ),
        "title": "Introduce",
        "content": Introduce(),
      },
      {
        "icon": Icon(
          Icons.contact_mail,
          color: Color.fromARGB(255, 160, 116, 196),
          size: 15,
        ),
        "title": "Contact",
        "content": Contact(),
      },
      {
        "icon": Icon(
          Icons.palette,
          color: Color.fromARGB(255, 227, 121, 51),
          size: 15,
        ),
        "title": "Works",
        "content": Works(),
      },
      {
        "icon": Icon(
          Icons.favorite,
          color: Color.fromARGB(255, 204, 62, 68),
          size: 15,
        ),
        "title": "Favorite",
        "content": Favorite(),
      },
    ];

    return ListView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.zero,
      children: <Widget>[
        for (int i = 0; i < contents.length; i++)
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              color: Layout.tabBarNonActiveBg,
              child: Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(7)),
                  contents[i]["icon"],
                  Padding(padding: EdgeInsets.all(3)),
                  Text(
                    contents[i]["title"],
                    style: TextStyle(
                      color: Layout.tabBarNonActiveLabel,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(20)),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget leftBar() {
    List<IconData> icons = [
      Icons.file_copy_outlined,
      Icons.search,
      Icons.bug_report,
    ];

    return Container(
      color: Layout.leftBarBg,
      width: 50,
      child: Column(
        children: [
          Padding(padding: EdgeInsets.all(10)),
          for (var i = 0; i < icons.length; i++)
            Column(
              children: [
                InkWell(
                  hoverColor: Colors.white,
                  child: Icon(
                    icons[i],
                    color: Color.fromARGB(255, 133, 133, 133),
                    size: 30,
                  ),
                  onTap: () {},
                ),
                Padding(padding: EdgeInsets.all(15)),
              ],
            ),
        ],
      ),
    );
  }

  BottomAppBar bottomBar() {
    return BottomAppBar(
      child: Container(
        height: 30.0,
        child: Row(
          children: [
            Container(
              height: 30,
              width: 200,
              alignment: Alignment.centerLeft,
              color: Layout.bottomBarRemoteBg,
              child: Text(
                ">< WSL: Ubuntu-20.04",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
                alignment: Alignment.centerLeft,
                color: Layout.bottomBarMainBg,
                child: Text(
                  "feature/#1_acannie*",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
