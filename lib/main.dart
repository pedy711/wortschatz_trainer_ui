import 'package:flutter/material.dart';
import 'package:wortschatz_trainer/locale/locales.dart';
import 'package:wortschatz_trainer/ui/homePage.dart';
import 'package:wortschatz_trainer/ui/loginPage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wortschatz_trainer/locale/locales.dart';

void main() => runApp(new MyApp());

final ThemeData _themeData = new ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  accentColor: Colors.brown,
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      /* localizationsDelegates: [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        Locale('en', ""),
        Locale('de', "")
      ],
      onGenerateTitle: (BuildContext context) =>
        AppLocalizations.of(context).title, */
      theme: _themeData,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: new LoginPage());
  }
}
