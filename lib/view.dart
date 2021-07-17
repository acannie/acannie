import 'dart:math';

import 'package:acannie/controller.dart';
import 'package:flutter/material.dart';

import 'layout.dart';
import 'content_view.dart';
import 'introduce.dart';
import 'contact.dart';
import 'works.dart';
import 'engineering.dart';
import 'favorite.dart';
import 'header_bar.dart';
import 'bottom_bar.dart';
import 'left_bar.dart';

// import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  PreferredSize headerBar() {
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
        Icons.computer,
        color: Color.fromARGB(255, 81, 154, 186),
        size: 15,
      ),
      "title": "Engineering",
      "content": Engineering(),
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
      appBar: headerBar(),
      body: DefaultTabController(
        length: contents.length,
        child: Builder(
          builder: (BuildContext context) {
            final TabController tabController =
                DefaultTabController.of(context)!;
            tabController.addListener(() {
              if (!tabController.indexIsChanging) {
                // To get index of current tab use tabController.index
              }
            });

            final AcannieController _controller =
                Provider.of<AcannieController>(context);
            return Row(
              children: [
                InkWell(
                    child: Icon(Icons.favorite),
                    onTap: () => {
                          tabController.animateTo(_controller.activePageIndex),
                          _controller.selectFileList(),
                        }),
                // BarWidgetClass().leftBar(),
                LeftBar(),
                // ページ一覧
                Visibility(
                    child: Text(_controller.pageListSelected.toString()),
                    visible: _controller.pageListSelected),

                Expanded(
                  child: Column(
                    children: [
                      // ページのタブ
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
                                unselectedLabelColor:
                                    Layout.tabBarNonActiveLabel,
                                controller: tabController,
                                isScrollable: true,
                                tabs: [
                                  for (int i = 0; i < contents.length; i++)
                                    Tab(
                                      icon: Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            right: BorderSide(
                                                color: Layout.tabBarBg),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(7),
                                            ),
                                            contents[i]["icon"],
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 3),
                                            ),
                                            Text(
                                              contents[i]["title"],
                                            ),
                                            Padding(
                                                padding: EdgeInsets.all(25)),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // ページ本体
                      Expanded(
                        child: TabBarView(
                          controller: tabController,
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
            );
          },
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
