import 'package:flutter/material.dart';
import 'package:wortschatz_trainer/ui/homePage.dart';


void main() => runApp(new MyApp());

final ThemeData _themeData = new ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  accentColor: Colors.brown
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: _themeData,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: new HomePage());
  }
}
