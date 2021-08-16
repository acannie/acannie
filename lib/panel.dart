import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'layout.dart';
import 'controller.dart';
import 'terminal_controller.dart';

class Panel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AcannieController _controller =
        Provider.of<AcannieController>(context);
    final TerminalController _terminalController =
        Provider.of<TerminalController>(context);

    return DefaultTabController(
      length: _controller.terminalContents.length,
      child: Builder(
        builder: (BuildContext context) {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: const Border(
                    top: const BorderSide(
                      color: Layout.terminalBorder,
                      width: 1,
                    ),
                  ),
                  color: Layout.tabBarActiveBg,
                ),
                height: 40,
                child: Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TabBar(
                          labelPadding: EdgeInsets.all(2.0),
                          indicatorPadding:
                              EdgeInsets.symmetric(horizontal: 10),
                          labelColor: Layout.terminalTabBarActiveLabel,
                          indicatorWeight: 1.0,
                          unselectedLabelColor:
                              Layout.terminalTabBarNonActiveLabel,
                          indicatorColor: Layout.terminalTabBarActiveLabel,
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
                      ),
                    ),
                    // ボタン群
                    Container(
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
                                    color: Layout.terminalIconButton,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {},
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3),
                          ),
                          // new terminal
                          InkWell(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add,
                                  color: Layout.terminalIconButton,
                                  size: 20,
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Layout.terminalIconButton,
                                  size: 15,
                                ),
                              ],
                            ),
                            onTap: () {},
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3),
                          ),
                          // split terminal
                          InkWell(
                            child: Icon(
                              Icons.view_column_outlined,
                              color: Layout.terminalIconButton,
                              size: 20,
                            ),
                            onTap: () {},
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3),
                          ),
                          // delete
                          InkWell(
                            child: Icon(
                              Icons.delete,
                              color: Layout.terminalIconButton,
                              size: 20,
                            ),
                            onTap: () {
                              _terminalController.deleteCommandLines();
                              _controller.switchTerminalActivity();
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3),
                          ),
                          // maximize panel size
                          InkWell(
                            child: Icon(
                              Icons.keyboard_arrow_up,
                              color: Layout.terminalIconButton,
                              size: 20,
                            ),
                            onTap: () {
                              _controller.switchPanelFullScreenMode();
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3),
                          ),
                          // close panel
                          InkWell(
                            child: Icon(
                              Icons.close,
                              color: Layout.terminalIconButton,
                              size: 15,
                            ),
                            onTap: () {
                              _controller.switchTerminalActivity();
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ],
                ),
              ),
              // ページ本体
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    for (TerminalContent terminalContent
                        in _controller.terminalContents)
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
          );
        },
      ),
    );
  }
}
