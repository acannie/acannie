import 'dart:math';

import 'package:flutter/material.dart';

import 'layout.dart';
import 'content_view.dart';
import 'introduce.dart';
import 'contact.dart';
import 'works.dart';
import 'favorite.dart';
import 'bar.dart';

// import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// ページ全体のレイアウトを生成
class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: contents.length, vsync: this);
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BarWidgetClass().appBarMain(),
      body: Row(
        children: [
          BarWidgetClass().leftBar(),
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 40,
                  child: Ink(
                    color: Layout.tabBarBg,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Ink(
                        color: Layout.tabBarNonActiveBg,
                        child: TabBar(
                          labelPadding: EdgeInsets.zero,
                          indicatorPadding: EdgeInsets.zero,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicator:
                              BoxDecoration(color: Layout.tabBarActiveBg),
                          labelColor: Layout.tabBarActiveLabel,
                          unselectedLabelColor: Layout.tabBarNonActiveLabel,
                          controller: _controller,
                          isScrollable: true,
                          tabs: [
                            for (int i = 0; i < contents.length; i++)
                              Tab(
                                icon: Row(
                                  children: [
                                    Padding(padding: EdgeInsets.all(7)),
                                    contents[i]["icon"],
                                    Padding(padding: EdgeInsets.all(3)),
                                    Text(
                                      contents[i]["title"],
                                    ),
                                    Padding(padding: EdgeInsets.all(20)),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _controller,
                    children: <Widget>[
                      for (int i = 0; i < contents.length; i++)
                        Container(
                          child: ContentView(contents[i]["content"]),
                          color: Layout.tabBarActiveBg,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BarWidgetClass().bottomBar(),
    );
  }
}
