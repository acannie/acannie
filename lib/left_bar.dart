import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

import 'layout.dart';
import 'controller.dart';

class LeftBar extends StatelessWidget {
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    List<IconData> icons = [
      Icons.file_copy_outlined,
      Icons.search,
      Icons.bug_report,
    ];
    final AcannieController _controller =
        Provider.of<AcannieController>(context);

    return Container(
      color: Layout.leftBarBg,
      width: 50,
      child: Column(
        children: [
          Padding(padding: EdgeInsets.all(10)),
          for (var i = 0; i < icons.length; i++)
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      color: Colors.white,
                      width: 2,
                      height: 60,
                    ),
                    Expanded(
                      child: Container(
                        width: 30,
                        color: Colors.yellow,
                        child: InkWell(
                          hoverColor: Colors.white,
                          child: Icon(
                            icons[i],
                            color: Color.fromARGB(255, 133, 133, 133),
                            size: 30,
                          ),
                          onTap: () {
                            _controller.selectFileList();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }
}
