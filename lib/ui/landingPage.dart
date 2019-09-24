import 'package:flutter/material.dart';
import 'package:wortschatz_trainer/models/user.dart';
import 'package:wortschatz_trainer/ui/cardsPage.dart';
import 'package:wortschatz_trainer/ui/homePage.dart';
import 'package:wortschatz_trainer/ui/loginPage.dart';
import 'package:wortschatz_trainer/ui/loginPage.dart' as prefix0;
import 'package:wortschatz_trainer/ui/signUpPage.dart';
import 'package:wortschatz_trainer/shared/constants.dart';
import 'package:wortschatz_trainer/shared/dbhelper.dart';
import 'package:wortschatz_trainer/models/globals.dart' as globals;

BuildContext _context;

class LandingPage extends StatefulWidget {
  @override
  createState() => _LandingPage();
}

class _LandingPage extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    // TODO initial state stuff
    
    new Future.delayed(const Duration(seconds: 4),
    () => createOrRetrieveUser());
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(body: LogoImageWidget());
  }

  void createOrRetrieveUser() {
    List<User> users = List<User>();
    DbHelper helper = DbHelper();
    helper
        .initializeDb()
        .then((result) => helper.getUsers().then((result) => users = result));

    if (users.isNotEmpty) {
      navigateTo(CardsPage());
    } else {
      navigateTo(HomePage());
    }
  }

  void navigateTo(Widget page) async {
    // TODO: check whether the age entered is over 18 years.
    bool result = await Navigator.push(
        _context, MaterialPageRoute(builder: (context) => page));
  }
}

class LogoImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage logoAsset = AssetImage('images/logo.png');
    Image image = Image(image: logoAsset);
    return FittedBox(
      child: image,
      fit: BoxFit.fitWidth,
    );
  }
}
