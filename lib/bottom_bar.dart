import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'layout.dart';
import 'controller.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AcannieController _controller =
        Provider.of<AcannieController>(context);

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
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
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
                alignment: Alignment.centerLeft,
                color: Layout.bottomBarMainBg,
                child: Text(
                  "feature/#1_acannie*",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
