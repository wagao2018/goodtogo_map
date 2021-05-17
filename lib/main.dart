import 'package:flutter/material.dart';
import 'map.dart';
import 'package:provider/provider.dart';
import 'package:good_to_go_app/CafeList.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CafeList(),
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GoodToGo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MapPage(),
    );
  }
}
