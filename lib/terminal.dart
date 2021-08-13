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
      length: _controller.terminalContents.length,
      child: Builder(
        builder: (BuildContext context) {
          final TabController tabController = DefaultTabController.of(context)!;
          tabController.addListener(() {
            if (!tabController.indexIsChanging) {}
          });

          return Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      // ページのタブ
                      Container(
                        height: 40,
                        child: Ink(
                          color: Layout.tabBarActiveBg,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(5),
                                ),
                                TabBar(
                                  labelPadding: EdgeInsets.all(2.0),
                                  indicatorPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                  labelColor: Layout.terminalTabBarActiveLabel,
                                  indicatorWeight: 1.0,
                                  unselectedLabelColor:
                                      Layout.terminalTabBarNonActiveLabel,
                                  indicatorColor:
                                      Layout.terminalTabBarActiveLabel,
                                  controller: tabController,
                                  isScrollable: true,
                                  tabs: [
                                    for (TerminalContent terminalContent
                                        in _controller.terminalContents)
                                      Tab(
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(5),
                                            ),
                                            Text(
                                              terminalContent.title,
                                              style: TextStyle(fontSize: 11),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(5),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                                Expanded(child: Container()),
                                // ボタン群
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    children: [
                                      // Bash
                                      InkWell(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.view_in_ar,
                                              color: Layout.terminalIconButton,
                                            ),
                                            Text(
                                              "bash",
                                              style: TextStyle(
                                                color:
                                                    Layout.terminalIconButton,
                                              ),
                                            ),
                                          ],
                                        ),
                                        onTap: () {},
                                      ),
                                      // new terminal
                                      InkWell(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.add,
                                              color: Layout.terminalIconButton,
                                            ),
                                            Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Layout.terminalIconButton,
                                              size: 10,
                                            ),
                                          ],
                                        ),
                                        onTap: () {},
                                      ),
                                      // split terminal
                                      InkWell(
                                        child: Icon(
                                          Icons.view_column_outlined,
                                          color: Layout.terminalIconButton,
                                        ),
                                        onTap: () {},
                                      ),
                                      // delete
                                      InkWell(
                                        child: Icon(
                                          Icons.delete,
                                          color: Layout.terminalIconButton,
                                        ),
                                        onTap: () {
                                          _controller.switchTerminalActivity();
                                        },
                                      ),
                                      // maximize panel size
                                      InkWell(
                                        child: Icon(
                                          Icons.keyboard_arrow_up,
                                          color: Layout.terminalIconButton,
                                        ),
                                        onTap: () {},
                                      ),
                                      // close panel
                                      InkWell(
                                        child: Icon(
                                          Icons.close,
                                          color: Layout.terminalIconButton,
                                        ),
                                        onTap: () {
                                          _controller.switchTerminalActivity();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // ページ本体
                      Expanded(
                        child: TabBarView(
                          controller: tabController,
                          children: <Widget>[
                            for (TerminalContent terminalContent
                                in _controller.terminalContents)
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: ListView(
                                  scrollDirection: Axis.vertical,
                                  children: <Widget>[
                                    terminalContent.content,
                                  ],
                                ),
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
