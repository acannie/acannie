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
        height: 20.0,
        child: Row(
          children: [
            Container(
              width: 140,
              alignment: Alignment.centerLeft,
              color: Layout.bottomBarRemoteBg,
              child: Text(
                ">< WSL: Ubuntu-20.04",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ),
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
