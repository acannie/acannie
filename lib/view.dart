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
      "icon": Icon(
        Icons.sentiment_satisfied_outlined,
        color: Color.fromARGB(255, 81, 154, 186),
        size: 15,
      ),
      "title": Text("Introduce"),
      "content": Introduce(),
    },
    {
      "icon": Icon(
        Icons.contact_mail,
        color: Color.fromARGB(255, 160, 116, 196),
        size: 15,
      ),
      "title": Text("Contact"),
      "content": Contact(),
    },
    {
      "icon": Icon(
        Icons.palette,
        color: Color.fromARGB(255, 227, 121, 51),
        size: 15,
      ),
      "title": Text("Works"),
      "content": Works(),
    },
    {
      "icon": Icon(
        Icons.favorite,
        color: Color.fromARGB(255, 204, 62, 68),
        size: 15,
      ),
      "title": Text("Favorite"),
      "content": Favorite(),
    },
  ];

  AppBar appBarMain() {
    return AppBar(
      title: Row(
        children: [
          Container(
            child: Flexible(child: Image.asset("wn_icon.png")),
            width: 30,
          ),
          Padding(padding: EdgeInsets.only(left: 20)),
          Text(
            'Acannie\'s HomePage',
            style: TextStyle(
                color: Color.fromARGB(255, 204, 204, 204), fontSize: 10),
          )
        ],
      ),
      backgroundColor: Color.fromARGB(255, 60, 60, 60),
      bottom: TabBar(
        // labelColor: Color.fromARGB(255, 244, 244, 244),
        unselectedLabelColor: Color.fromARGB(255, 150, 150, 150),
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(color: Color.fromARGB(255, 30, 30, 30)),
        indicatorPadding: EdgeInsets.zero,
        isScrollable: true,
        tabs: [
          for (int i = 0; i < contents.length; i++)
            Tab(
              iconMargin: EdgeInsets.zero,
              icon: Expanded(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      contents[i]["icon"],
                      Padding(padding: EdgeInsets.all(3)),
                      contents[i]["title"],
                      Padding(padding: EdgeInsets.all(20)),
                    ],
                  ),
                ),
              ),
            ),
          // Tab(
          //   child: Align(
          //     alignment: Alignment.center,
          //     child: Text("APPS"),
          //   ),
          // ),
        ],
      ),

      //     TabBar(
      // labelColor: Colors.red,
      // unselectedLabelColor: Colors.yellow,
      // isScrollable: true,
      // indicatorColor: Color.fromARGB(255, 60, 60, 60),
      // tabs: <Widget>[
      //   for (int i = 0; i < contents.length; i++)
      //     Tab(
      //       iconMargin: EdgeInsets.all(0),
      //       icon: Expanded(
      //         child: Container(
      //           child: Row(
      //             children: <Widget>[
      //               contents[i]["icon"],
      //               Padding(padding: EdgeInsets.all(10)),
      //               contents[i]["title"],
      //             ],
      //           ),
      //           color: Colors.green,
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
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
        backgroundColor: Color.fromARGB(255, 30, 30, 30),
      ),
    );
  }
}
