import 'dart:math';

import 'package:acannie/controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'layout.dart';
import 'content_view.dart';
import 'bottom_bar.dart';
import 'left_bar.dart';
import 'file_list.dart';
import 'search.dart';
import 'bug_report.dart';
import 'terminal.dart';

// 左側のバーのアイコン関連の情報
class LeftBarListContent {
  IconData iconData;
  Widget content;

  LeftBarListContent({
    required this.iconData,
    required this.content,
  });
}

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

  @override
  Widget build(BuildContext context) {
    final AcannieController _controller =
        Provider.of<AcannieController>(context);

    return Scaffold(
      appBar: headerBar(),
      body: Row(
        children: [
          LeftBar(),
          DefaultTabController(
            length: _controller.pageContents.length,
            child: Builder(
              builder: (BuildContext context) {
                final TabController tabController =
                    DefaultTabController.of(context)!;
                tabController.addListener(() {
                  if (!tabController.indexIsChanging) {
                    _controller.setActivePage(tabController.index);
                  }
                });

                // 左側のバーのアイコン関連の情報一覧
                List<LeftBarListContent> leftBarListContents = [
                  LeftBarListContent(
                    iconData: Icons.file_copy_outlined,
                    content: FileList(tabController: tabController),
                  ),
                  LeftBarListContent(
                    iconData: Icons.search,
                    content: Search(),
                  ),
                  LeftBarListContent(
                    iconData: Icons.bug_report,
                    content: BugReport(),
                  ),
                ];

                return Expanded(
                  child: Row(
                    children: [
                      // 左側のバーのアイコンをタップしたときに表示される領域
                      for (int i = 0; i < leftBarListContents.length; i++)
                        Visibility(
                          child: leftBarListContents[i].content,
                          visible: _controller.leftListActive &&
                              _controller.activeLeftBarIconIndex == i,
                        ),

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
                                      indicator: BoxDecoration(
                                          color: Layout.tabBarActiveBg),
                                      labelColor: Layout.tabBarActiveLabel,
                                      unselectedLabelColor:
                                          Layout.tabBarNonActiveLabel,
                                      controller: tabController,
                                      isScrollable: true,
                                      tabs: [
                                        for (PageContent pageContent
                                            in _controller.pageContents)
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
                                                  Icon(
                                                    pageContent.iconData,
                                                    color:
                                                        pageContent.iconColor,
                                                    size: 15,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 3),
                                                  ),
                                                  Text(
                                                    pageContent.title,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.all(25),
                                                  ),
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
                              flex: 2,
                              child: TabBarView(
                                controller: tabController,
                                children: <Widget>[
                                  for (PageContent pageContent
                                      in _controller.pageContents)
                                    Container(
                                      child:
                                          ContentView(pageContent: pageContent),
                                      color: Layout.tabBarActiveBg,
                                    ),
                                ],
                              ),
                            ),
                            // Terminal部
                            Visibility(
                              child: Terminal(),
                              visible: _controller.terminalActive,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomBar(),
      floatingActionButton: Visibility(
        visible: !_controller.terminalActive,
        child: FloatingActionButton(
          onPressed: () {
            _controller.switchTerminalActivity();
          },
          child: const Icon(Icons.web_asset),
          backgroundColor: Color.fromARGB(255, 104, 33, 122),
        ),
      ),
    );
  }
}
