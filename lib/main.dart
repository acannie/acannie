import 'package:acannie/powershell_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'view.dart';
import 'controller.dart';
import 'file_list.dart';
import 'ubuntu_controller.dart';
import 'powershell_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'Acannie のホームぺージ';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
        child: MyHomePage(),
        providers: [
          ChangeNotifierProvider(create: (context) => AcannieController()),
          ChangeNotifierProvider(create: (context) => DropDownListCotroller()),
          ChangeNotifierProvider(create: (context) => UbuntuController()),
          ChangeNotifierProvider(create: (context) => PowerShellController()),
        ],
      ),
    );
  }
}
