import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

import 'layout.dart';
import 'controller.dart';

class Terminal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AcannieController _controller =
        Provider.of<AcannieController>(context);
    return DefaultTabController(
      length: _controller.pageContents.length,
      child: Builder(
        builder: (BuildContext context) {
          final TabController tabController = DefaultTabController.of(context)!;
          tabController.addListener(() {
            if (!tabController.indexIsChanging) {
              // _controller.setActivePage(tabController.index);
            }
          });

          return Expanded(
            child: Row(
              children: [
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
                                              color: pageContent.iconColor,
                                              size: 15,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
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
                        child: TabBarView(
                          controller: tabController,
                          children: <Widget>[
                            for (PageContent pageContent
                                in _controller.pageContents)
                              Container(
                                child: Text("aaa"),
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
          );
        },
      ),
    );
  }
}
