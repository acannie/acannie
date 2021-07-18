import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

import 'layout.dart';
import 'controller.dart';

class BottomBar extends StatelessWidget {
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final AcannieController _controller =
        Provider.of<AcannieController>(context);

    return BottomAppBar(
      child: Container(
        height: 30.0,
        child: Row(
          children: [
            Container(
              height: 30,
              width: 200,
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
                height: 30,
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
