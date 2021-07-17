import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

import 'layout.dart';
import 'controller.dart';

class DropDownListCotroller with ChangeNotifier {
  // 定数
  // 変数

  bool get flg => _flg;
  bool _flg = true;

  // 関数
  void dropDown() {
    _flg = !_flg;
    notifyListeners();
  }
}

class FileList extends StatelessWidget {
  final TabController tabController;

//受け取る値を上記の変数に代入
  FileList({required this.tabController});

  @override
  Widget build(BuildContext context) {
    final AcannieController _controller =
        Provider.of<AcannieController>(context);

    final DropDownListCotroller _dropDownListCotroller =
        Provider.of<DropDownListCotroller>(context);

    bool flg = true;

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
          InkWell(
            child: Row(children: [
              if (_dropDownListCotroller.flg)
                Icon(Icons.keyboard_arrow_down)
              else
                Icon(Icons.navigate_next_rounded),
              Text("ACANNIE"),
            ]),
            onTap: () => {_dropDownListCotroller.dropDown()},
          ),
          Visibility(
            visible: _dropDownListCotroller.flg,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _controller.contents.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
          ),
        ],
      ),
    );
  }
}
