import 'package:flutter/material.dart';
import 'package:wortschatz_trainer/models/user.dart';
import 'package:wortschatz_trainer/ui/loginPage.dart';
import 'package:wortschatz_trainer/ui/signUpPage.dart';
import 'package:wortschatz_trainer/shared/constants.dart';
import 'package:wortschatz_trainer/shared/dbhelper.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            alignment: Alignment.center,
            color: Colors.tealAccent,
            child: Column(
              children: <Widget>[
                LogoImageWidget(),
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 50.0),
                  child: Text(Constants.APP_NAME_PERSIAN,
                      textScaleFactor: 1.5,
                      style: TextStyle(
                          fontSize: 40.0,
                          decoration: TextDecoration.none,
                          color: Colors.blueAccent)),
                ),
                RaisedButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                    child: Text(
                      Constants.BECOME_A_MEMBER,
                      textScaleFactor: 1.5,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    textColor: Colors.white,
                    color: Colors.blueAccent,
                    onPressed: () => navigateToSignUpPage(context)),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                ),
                RaisedButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                    child: Text(
                      Constants.ALREADY_A_MEMBER_TEXT,
                      textScaleFactor: 1.5,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    textColor: Colors.white,
                    color: Colors.blueAccent,
                    onPressed: () => navigateToLoginPage(context)),
              ],
            )));
  }

  void navigateToLoginPage(BuildContext context) async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void navigateToSignUpPage(BuildContext context) async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpPage()));
  }
}

class LogoImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage logoAsset = AssetImage('images/heart.png');
    Image image = Image(image: logoAsset, width: 200.0, height: 200.0);
    return Container(
      child: image,
      padding: EdgeInsets.all(50.0),
    );
  }
}
