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
      backgroundColor: Color.fromARGB(255, 51, 51, 51),
      elevation: 0,
      bottom: TabBar(
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget leftBar() {
      return Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                children: [
                  Icon(
                    Icons.file_copy_outlined,
                    color: Color.fromARGB(255, 133, 133, 133),
                    size: 30,
                  ),
                  Padding(padding: EdgeInsets.all(15)),
                  Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 133, 133, 133),
                    size: 30,
                  ),
                  Padding(padding: EdgeInsets.all(15)),
                  Icon(
                    Icons.bug_report,
                    color: Color.fromARGB(255, 133, 133, 133),
                    size: 30,
                  ),
                ],
              ),
              color: Color.fromARGB(255, 51, 51, 51),
              width: 50,
            ),
          ),
        ],
      );
    }

    final PageController controller = PageController(initialPage: 0);
    return DefaultTabController(
      initialIndex: 0,
      length: contents.length,
      child: Scaffold(
        appBar: appBarMain(),
        // body: TabBarView(
        //   children: <Widget>[
        body: Row(
          children: <Widget>[
            leftBar(),
            // PageView(
            //   scrollDirection: Axis.horizontal,
            //   controller: controller,
            //   children: <Widget>[
            //     for (int i = 0; i < contents.length; i++) contents[i]["content"],
            //   ],
            // ),
            Expanded(
              child: Container(
                child: Card(
                  color: Color.fromARGB(255, 30, 30, 30),
                  child: Text('introduce'),
                ),
                height: 25,
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black)),
                ),
              ),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        // ],
        // ),
        backgroundColor: Color.fromARGB(255, 30, 30, 30),
        bottomNavigationBar: BottomAppBar(
          // shape: const CircularNotchedRectangle(),
          child: Container(
            height: 20.0,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 20,
                    color: Color.fromARGB(255, 22, 130, 93),
                    child: Text("aaa"),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Container(
                    height: 20,
                    color: Color.fromARGB(255, 0, 122, 204),
                    child: Text("bbb"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
