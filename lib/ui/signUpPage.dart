import 'package:flutter/material.dart';
import 'package:wortschatz_trainer/models/user.dart';
import 'package:wortschatz_trainer/ui/introductionPage.dart';

//import 'package:carousel_slider/carousel_slider.dart';
import 'package:wortschatz_trainer/ui/loginPage.dart';
import 'package:wortschatz_trainer/shared/constants.dart';
import 'package:wortschatz_trainer/shared/httphelper.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import 'package:validate/validate.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController repeatPasswordController = TextEditingController();
TextEditingController signUpController = TextEditingController();
String btnText = Constants.NEXT_TEXT;
const jasonCodec = const JsonCodec();
BuildContext _context;

PageController _pageController = PageController();
PageView _pageView = PageView();

class SignUpPage extends StatefulWidget {
  @override
  createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
//  CarouselSlider carouselSlider;
  String nextBtnText = Constants.NEXT_TEXT;
  final GlobalKey<FormState> _formEmailKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    emailController.text = "pedram.khoshdani@gmail.com";
    passwordController.text = "12345678";
    repeatPasswordController.text = "12345678";

    _context = context;
    TextStyle textStyle = Theme.of(context).textTheme.title;

    _pageView = new PageView(
      children: <Widget>[createSignUpForm(textStyle)],
      controller: _pageController,
    );

    return new Scaffold(
      backgroundColor: Colors.tealAccent,
      body: _pageView,
    );
  }

  void submit() {
    // First validate form.
    if (this._formEmailKey.currentState.validate()) {
      _formEmailKey.currentState.save(); // Save our form now.

      registerUser().then((response) => print("Response body: " + response));

      print('Printing the login data.');
      print('Email: ${emailController.text}');
      print('Password: ${passwordController.text}');
    }

    /* if (this._formPasswordKey.currentState.validate()){
      _formPasswordKey.currentState.save(); // Save our form now.

      registerUser().then((response) => print("Response body: " + response));
    }*/
  }

  RaisedButton buildRaisedButton() {
    return RaisedButton(
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0)),
        padding:
            EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
        child: Text(
          btnText = Constants.SIGN_UP,
          textScaleFactor: 1.5,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        textColor: Colors.white,
        color: Colors.blueAccent,
        onPressed: () {
          submit();
        });
  }

  void nextPage() {
    _pageController.nextPage(
        duration: new Duration(milliseconds: 300), curve: Curves.linear);
  }

  Widget createSignUpForm(textStyle) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Form(
        key: this._formEmailKey,
        child: ListView(children: <Widget>[
          createEmailTextFormField(textStyle),
          createPasswordTextFormField(textStyle),
          createRepeatPasswordTextFormField(textStyle),
          buildRaisedButton()
        ]),
      ),
    );
  }

/*  Widget createUsernameField(textStyle) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Form(
        key: this._formEmailKey,
        child: ListView(children: <Widget>[
          createEmailTextFormField(textStyle),
          buildRaisedButton(false)
        ]),
      ),
    );
  }

  Widget createPasswordFields(textStyle) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Form(
        key: this._formPasswordKey,
        child: ListView(children: <Widget>[
          createPasswordTextFormField(textStyle),
          buildRaisedButton(true)
        ]),
      ),
    );
  }*/

  Padding createEmailTextFormField(textStyle) {
    return Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: TextFormField(
          controller: emailController,
          decoration: InputDecoration(
              labelText: Constants.EMAIL_TEXT,
              labelStyle: textStyle,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0))),
          keyboardType: TextInputType.emailAddress,
          validator: _validateEmail,
//          onEditingComplete: _validateEmail,
        ));
  }

  Padding createPasswordTextFormField(textStyle) {
    return Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: TextFormField(
          obscureText: true,
          controller: passwordController,
          decoration: InputDecoration(
              labelText: Constants.PASSWORD_TEXT,
              labelStyle: textStyle,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0))),
          keyboardType: TextInputType.text,
          validator: _validatePassword,
//          onSaved: (val) => _validateEmail(val),
        ));
  }

  Padding createRepeatPasswordTextFormField(textStyle) {
    return Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: TextFormField(
          obscureText: true,
          controller: repeatPasswordController,
          decoration: InputDecoration(
              labelText: Constants.REPEAT_PASSWORD_TEXT,
              labelStyle: textStyle,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0))),
          keyboardType: TextInputType.text,
          validator: _validateRepeatPassword,
//          onSaved: (val) => _validateEmail(val),
        ));
  }

  String _validateRepeatPassword(String value) {
    if (value != passwordController.text) {
      return 'The passwords do not match.';
    }

    return null;
  }

  // Add validate password function.
  String _validatePassword(String value) {
    if (value.length < 8) {
      return 'The password must be at least 8 characters.';
    }

    return null;
  }

  // Add validate email function.
  String _validateEmail(String value) {
    try {
      Validate.isEmail(value);
//      TODO: make a call to see if this email address already exists
    } catch (e) {
      return 'The E-mail address must be a valid email address.';
    }

    return null;
  }

  Future<String> registerUser() async {
    User user = new User.withEmailPassword(
        emailController.text, passwordController.text);

    HttpHelper http = HttpHelper();
    http.post(json.encode(user.toJson()), Constants.REGISTER_USER)
        .then((response) {
      if (response.statusCode == 201) {
        // registration accepted: go to next
        navigateToPage(IntroductionPage());
      } else {
        // user already exists: go to sign in page
        print(response.statusCode);
        navigateToPage(LoginPage());
      }
    });
  }

  void navigateToPage(Widget page) async {
    bool result = await Navigator.push(
        _context, MaterialPageRoute(builder: (context) => page));
  }
}
