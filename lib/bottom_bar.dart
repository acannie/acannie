import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'layout.dart';
import 'controller.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AcannieController _controller =
        Provider.of<AcannieController>(context);

    TextStyle _bottomBarStyle = TextStyle(
      color: Colors.white,
      fontSize: 13,
    );

    return BottomAppBar(
      child: Container(
        height: 22,
        child: Row(
          children: [
            // WSL のボタン
            Container(
              alignment: Alignment.center,
              color: Layout.bottomBarRemoteBg,
              child: InkWell(
                  child: Row(
                    children: [
                      Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                      Icon(
                        Icons.compare_arrows,
                        color: Colors.white,
                        size: 20,
                      ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 1)),
                      Visibility(
                        visible: _controller.wslMode,
                        child: Text(
                          "WSL: Ubuntu-20.04",
                          style: _bottomBarStyle,
                        ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 7)),
                    ],
                  ),
                  onTap: () {
                    _controller.switchWslMode();
                  }),
            ),

            // メインのバー
            Expanded(
              child: Container(
                height: 22,
                color: Layout.bottomBarMainBg,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 左側のアイコン群
                    Container(
                      child: Row(
                        children: [
                          Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                          Icon(
                            Icons.share,
                            color: Colors.white,
                            size: 15,
                          ),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 1)),
                          Text("feature/#123_acannie*", style: _bottomBarStyle),
                          Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 10,
                          ),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 7)),
                          Icon(
                            Icons.cached,
                            color: Colors.white,
                            size: 15,
                          ),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 7)),
                          Icon(
                            Icons.highlight_off,
                            color: Colors.white,
                            size: 15,
                          ),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 1)),
                          Text("0", style: _bottomBarStyle),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 1)),
                          Icon(
                            Icons.warning_amber,
                            color: Colors.white,
                            size: 15,
                          ),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 1)),
                          Text("0", style: _bottomBarStyle),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 1)),
                          Icon(
                            Icons.info_outline,
                            color: Colors.white,
                            size: 15,
                          ),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 1)),
                          Text("0", style: _bottomBarStyle),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 7)),
                          Icon(
                            Icons.play_arrow_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 7)),
                        ],
                      ),
                    ),
                    // 右側のアイコン群
                    Container(
                      child: Row(
                        children: [
                          Text("aaa"),
                          Text("bbb"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
