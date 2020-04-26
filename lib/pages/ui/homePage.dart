import 'package:flutter/material.dart';
import 'package:wortschatz_trainer/pages/custom_widgets/RaisedButtonWidget.dart';
import 'package:wortschatz_trainer/services/constants.dart';

import 'loginPage.dart';
import 'signUpPage.dart';

class HomePage extends StatelessWidget {
  final double roundedCorner = 10;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        color: Colors.white,
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
                    buildRegisterTxt(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 25.0),
                      child: buildRegisterOrLoginTxt(),
                    ),
                  ],
                ),
                buildRegisterWithEmailBtn(context),
                buildFacebookLoginBtn(context),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 40.0, bottom: 0.0),
                      child: buildMemberQuestionTxt(),
                    )
                  ],
                ),
                buildRaisedButton(context)
              ],
            )));
  }

  Text buildRegisterTxt() {
    return Text(Constants.REGISTER,
        // textScaleFactor: 1.5,
        style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 30.0,
            decoration: TextDecoration.none,
            fontFamily: 'Roboto-Thin'));
  }

  Text buildRegisterOrLoginTxt() {
    return Text(Constants.REGISTER_OR_LOGIN,
        // textScaleFactor: 1.5,
        style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 25.0,
            decoration: TextDecoration.none,
            fontFamily: 'Roboto-Thin'));
  }

  Widget buildRegisterWithEmailBtn(BuildContext context) {
    return RaisedButtonWidget(
        btnTxt: Constants.BECOME_A_MEMBER,
        onPressed: () => navigateToSignUpPage(context),
        color: Colors.red[800]);
  }

  Widget buildFacebookLoginBtn(BuildContext context) {
    return RaisedButtonWidget(
        btnTxt: Constants.LOGIN_WITH_FACEBOOK,
        onPressed: () => navigateToLoginPage(context),
        color: Colors.blue[900]);
  }

  Text buildMemberQuestionTxt() {
    return Text(Constants.ALREADY_A_MEMBER_TEXT,
        // textScaleFactor: 1.5,
        style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 20.0,
            decoration: TextDecoration.none,
            fontFamily: 'Roboto-Thin'));
  }

  Widget buildRaisedButton(BuildContext context) {
    return RaisedButtonWidget(
        btnTxt: Constants.LOGIN,
        onPressed: () => navigateToLoginPage(context),
        color: Colors.red[800]);
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
