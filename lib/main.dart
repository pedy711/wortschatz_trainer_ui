import 'package:flutter/material.dart';
import 'package:wortschatz_trainer/locale/locales.dart';
import 'package:wortschatz_trainer/ui/cardsPage.dart';
import 'package:wortschatz_trainer/ui/flashcardPage.dart';
import 'package:wortschatz_trainer/ui/homePage.dart';
import 'package:wortschatz_trainer/ui/loginPage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wortschatz_trainer/locale/locales.dart';

void main() => runApp(new MyApp());

final ThemeData _themeData = new ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.purple,
  accentColor: Colors.brown,
  // textTheme: TextTheme(
  //   body1: TextStyle(
  //     fontSize: 24,
  //   )
  // )
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
      home: new CardsPage());
  }
}
