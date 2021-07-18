import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

import 'layout.dart';
import 'controller.dart';
import 'layout.dart';

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

  // 受け取る値を上記の変数に代入
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
      color: Layout.fileListBg,
      child: Column(
        children: [
          // EXPLORER
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Text(
                  "EXPLORER",
                  style: TextStyle(color: Layout.fileListLabel, fontSize: 10),
                ),
                InkWell(
                  child: Icon(Icons.more_horiz,
                      color: Layout.fileListLabel, size: 20),
                  onTap: () => {},
                ),
              ],
            ),
          ),
          // 項目名
          InkWell(
            child: Row(
              children: [
                if (_dropDownListCotroller.flg)
                  Icon(Icons.keyboard_arrow_down, color: Layout.fileListLabel)
                else
                  Icon(Icons.navigate_next_rounded,
                      color: Layout.fileListLabel),
                Text(
                  "ACANNIE",
                  style: TextStyle(
                      color: Layout.fileListLabel, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () => {_dropDownListCotroller.dropDown()},
          ),
          // ファイル一覧
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
                      child: Container(
                        decoration: BoxDecoration(
                          color: () {
                            if (_controller.activePageIndex == index) {
                              return Color.fromARGB(255, 9, 71, 113);
                            }
                          }(),
                          border: () {
                            if (_controller.activePageIndex == index) {
                              return Border.all(
                                color: Color.fromARGB(255, 0, 127, 211),
                              );
                            }
                          }(),
                        ),
                        child: TextButton(
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(7),
                              ),
                              Icon(
                                _controller.pageContents[index].iconData,
                                color:
                                    _controller.pageContents[index].iconColor,
                                size: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3),
                              ),
                              Text(
                                _controller.contents[index],
                                style: TextStyle(color: () {
                                  if (_controller.activePageIndex == index) {
                                    return Layout.fileListActiveLabel;
                                  } else {
                                    return Layout.fileListLabel;
                                  }
                                }()),
                              ),
                            ],
                          ),
                          onPressed: () => {
                            _controller.setActivePage(index),
                            tabController
                                .animateTo(_controller.activePageIndex),
                          },
                        ),
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
