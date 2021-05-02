import 'package:flutter/material.dart';

import 'layout.dart';
import 'introduce.dart';
// import 'contact.dart';
// import 'works.dart';
// import 'favorite.dart';
import 'bar.dart';

// ページ全体のレイアウトを生成
class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final PageController controller = PageController(initialPage: 0);

    return Scaffold(
      appBar: BarWidgetClass().appBarMain(),
      body: Row(
        children: <Widget>[
          BarWidgetClass().leftBar(),
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 40,
                  child: Container(
                    color: Layout.tabBarBg,
                    child: BarWidgetClass().tabBar(),
                  ),
                ),
                Expanded(
                  flex: 20,
                  child: Container(
                    child: Introduce(),
                    color: Layout.tabBarActiveBg,
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
