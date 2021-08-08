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
          for (var i = 0; i < icons.length; i++)
            Column(
              children: [
                Row(
                  children: [
                    // indecator
                    Container(
                      color: () {
                        if (_controller.activeLeftBarIconIndex == i) {
                          return Layout.fileListActiveLabel;
                        }
                        return Layout.leftBarBg;
                      }(),
                      width: 2,
                      height: 50,
                    ),
                    // Icon
                    Expanded(
                      child: Container(
                        width: 30,
                        child: InkWell(
                          hoverColor: Colors.white,
                          child: Icon(
                            icons[i],
                            color: () {
                              if (_controller.activeLeftBarIconIndex == i) {
                                return Layout.fileListActiveLabel;
                              }
                              return Layout.fileListNonActiveLabel;
                            }(),
                            size: 25,
                          ),
                          onTap: () {
                            _controller.tapLeftBarIcon(i);
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
