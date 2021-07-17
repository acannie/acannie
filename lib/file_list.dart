import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

import 'layout.dart';
import 'controller.dart';

class FileList extends StatelessWidget {
  final TabController tabController;

//受け取る値を上記の変数に代入
  FileList({required this.tabController});

  @override
  Widget build(BuildContext context) {
    final AcannieController _controller =
        Provider.of<AcannieController>(context);

    return Container(
      width: 200,
      color: Colors.red,
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Text("EXPLORER"),
                InkWell(
                  child: Icon(Icons.more_horiz),
                  onTap: () => {},
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: _controller.contents.length,
            itemBuilder: (BuildContext context, int index) {
              // 初期値
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextButton(
                      child: Text(_controller.contents[index]),
                      onPressed: () => {
                        _controller.setActivePage(index),
                        tabController.animateTo(_controller.activePageIndex),
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
