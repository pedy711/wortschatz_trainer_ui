import 'package:flutter/material.dart';
import 'package:wortschatz_trainer/ui/loginPage.dart';
import 'package:wortschatz_trainer/ui/signUpPage.dart';
import 'package:wortschatz_trainer/shared/constants.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        color: Colors.red[50],
        child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                LogoImageWidget(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(Constants.REGISTER,
                        // textScaleFactor: 1.5,
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 30.0,
                            decoration: TextDecoration.none,
                            fontFamily: 'Roboto-Thin')),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 50.0),
                      child: Text(Constants.REGISTER_OR_LOGIN,
                          // textScaleFactor: 1.5,
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 25.0,
                              decoration: TextDecoration.none,
                              fontFamily: 'Roboto-Thin')),
                    ),
                  ],
                ),
                RaisedButton(
                    // shape: new RoundedRectangleBorder(
                    //     borderRadius: new BorderRadius.circular(30.0)),
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                    child: Text(
                      Constants.BECOME_A_MEMBER,
                      textScaleFactor: 1.5,
                      // style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    textColor: Colors.white,
                    color: Colors.blueAccent,
                    onPressed: () => navigateToSignUpPage(context)),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                ),
                RaisedButton(
                    // shape: new RoundedRectangleBorder(
                    //     borderRadius: new BorderRadius.circular(30.0)),
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                    child: Text(
                      Constants.ALREADY_A_MEMBER_TEXT,
                      textScaleFactor: 1.5,
                    ),
                    textColor: Colors.white,
                    color: Colors.blueAccent,
                    onPressed: () => navigateToLoginPage(context)),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 50.0),
                      child: Text(Constants.ALREADY_A_MEMBER_TEXT,
                          // textScaleFactor: 1.5,
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 25.0,
                              decoration: TextDecoration.none,
                              fontFamily: 'Roboto-Thin')),
                    ),
                  ],
                ),
                RaisedButton(
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                    child: Text(
                      Constants.LOGIN,
                      textScaleFactor: 1.5,
                    ),
                    textColor: Colors.white,
                    color: Colors.blueAccent,
                    onPressed: () => navigateToLoginPage(context))
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
    Image image = Image(image: logoAsset, width: 100.0, height: 100.0);
    return Container(
      child: image,
      padding: EdgeInsets.all(50.0),
    );
  }
}
