import 'package:flutter/material.dart';
import 'package:wortschatz_trainer/custom_widgets/RaisedButtonWidget.dart';
import 'package:wortschatz_trainer/custom_widgets/TextBoxWidget.dart';
import 'package:wortschatz_trainer/models/user.dart';
import 'package:wortschatz_trainer/ui/introductionPage.dart';
import 'package:wortschatz_trainer/shared/constants.dart';
import 'package:wortschatz_trainer/shared/dbhelper.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

String emailStr = "";

class LoginPage extends StatefulWidget {
  @override
  createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    this._context = context;
/*     emailController.text = "pedram.khoshdani@gmail.com";
    passwordController.text = "12345678"; */

    var emailTextField = Padding(
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: TextFieldWidget(
            text: Constants.EMAIL_TEXT,
            controller: emailController,
            textStyle: textStyle,
            keyboardType: TextInputType.emailAddress,
            onChanged: (String string) {
              setState(() {
                email = string;
              });
            })
        /* TextField(
          controller: emailController,
          decoration: InputDecoration(
              labelText: Constants.EMAIL_TEXT,
              labelStyle: textStyle,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0))),
          keyboardType: TextInputType.emailAddress,
          onChanged: (String string) {
            setState(() {
              email = string;
            });
          },
        ) */
        );

    var passwordTextField = Padding(
        padding: EdgeInsets.only(bottom: 10.0),
        child: TextFieldWidget(
            text: Constants.PASSWORD_TEXT,
            controller: passwordController,
            textStyle: textStyle,
            // obscureText: true,
            keyboardType: TextInputType.text,
            onChanged: (String string) {
              setState(() {
                password = string;
              });
            })
        /* TextField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
              labelText: Constants.PASSWORD_TEXT,
              labelStyle: textStyle,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0))),
          keyboardType: TextInputType.text,
          onChanged: (String string) {
            setState(() {
              password = string;
            });
          },
        ) */
        );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    return new Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
            LogoImageWidget(),
            SizedBox(height: 48.0),
            emailTextField,
            SizedBox(height: 8.0),
            passwordTextField,
            SizedBox(height: 24.0),
            createSubmitBtn(),
            // SubmitBtnWidget(),
            forgotLabel
          ])),
    );
  }

  createSubmitBtn() {
    return RaisedButtonWidget(
        btnTxt: Constants.LOGIN,
        onPressed: () => submit(_context),
        color: Colors.red[800]);
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

void navigateToIntroductionPage(BuildContext context) async {
  bool result = await Navigator.push(
      context, MaterialPageRoute(builder: (context) => IntroductionPage()));
}

void submit(BuildContext context) {
  // try to login the user

  navigateToIntroductionPage(context);
  /*var alert = AlertDialog(
      title: Text("Submitted"),
      content: Text("Thanks for visiting us"),
    );
    showDialog(context: context, builder: (BuildContext context) => alert);*/
}

/* class SubmitBtnWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var button = Container(
      margin: EdgeInsets.only(top: 25.0),
      child: RaisedButton(
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        child: Text(
          Constants.LOGIN,
          textScaleFactor: 1.5,
        ),
        color: Colors.lightBlue,
        elevation: 5.0,
        onPressed: () {
          submit(context);
        },
      ),
    );

    return button;
  }

  void submit(BuildContext context) {
    // try to login the user

    navigateToIntroductionPage(context);
    /*var alert = AlertDialog(
      title: Text("Submitted"),
      content: Text("Thanks for visiting us"),
    );
    showDialog(context: context, builder: (BuildContext context) => alert);*/
  }

  void navigateToIntroductionPage(BuildContext context) async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => IntroductionPage()));
  }
} */
