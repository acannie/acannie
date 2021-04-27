import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 自己紹介
class Layout {
  Text titleText(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Color.fromARGB(255, 212, 212, 212),
        fontWeight: FontWeight.bold,
        fontSize: 40,
      ),
    );
  }

  Widget historyTable(List<Map<String, String>> history) {
    return Column(
      children: <Widget>[
        for (int i = 0; i < history.length; i++)
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(history[i]["when"]!),
                Text(history[i]["event"]!),
                // Flexible(
                //   flex: 1,
                //   child: Container(
                //     color: Colors.blue,
                //     child: Text('Flexible\n\n(flex:1)'),
                //   ),
                // ),
              ],
            ),
          ),
      ],
    );
  }
}
