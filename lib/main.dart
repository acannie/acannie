import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'view.dart';
import 'controller.dart';

void main() {
  runApp(MyApp());
}

// ルートの Widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JOHINKODICE',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
        child: MyHomePage(),
        providers: [
          ChangeNotifierProvider(create: (context) => AcannieController()),
        ],
      ),
    );
  }
}