import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wortschatz_trainer/custom_widgets/RaisedButtonWidget.dart';
import 'package:wortschatz_trainer/models/FlashCard.dart';
import 'package:wortschatz_trainer/models/communication/dataSourceResponse.dart';
import 'package:wortschatz_trainer/models/communication/dsRequest.dart';
import 'package:wortschatz_trainer/models/user.dart';
import 'package:wortschatz_trainer/shared/constants.dart';
import 'package:wortschatz_trainer/ui/flashcardPage.dart';

BuildContext _context;
const jasonCodec = const JsonCodec();

class CardsPage extends StatefulWidget {
  @override
  createState() => _CardsPage();
}

class _CardsPage extends State<CardsPage> {
  PageView _pageView = PageView();
  PageController _pageController = PageController();
  List<FlashCard> _cards = new List<FlashCard>();
  // List<Padding> cards = new List<Padding>();
  int _total = 0;
  var cachedData = new Map<int, User>();

  @override
  void initState() {
    /* getFirst50Cards().then((users) {
      setState(() {
        _users = users;
      });
    }); */
    for (var i = 0; i < 10; i++) {
      FlashCard card = new FlashCard('Buch', 'Book');
      _cards.add(card);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    var rowsOfCards = Column(
                    children: <Widget>[
                      buildFittedBox(),
                      buildFittedBox(),
                      buildFittedBox(),
                      buildFittedBox(),
                      buildFittedBox(),
                    ],
                  );
        return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: ListView(
                padding: EdgeInsets.only(
                  top: 50,
                ),
                children: <Widget>[
                  Center(
                      child: Padding(
                    padding: EdgeInsets.only(bottom: 40),
                    child: Text(Constants.TODAY_WORD_LIST,
                        // textScaleFactor: 1.5,
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 30.0,
                            decoration: TextDecoration.none,
                            fontFamily: 'Roboto-Thin')),
                  )),
                 rowsOfCards,
              Padding(
                padding: EdgeInsets.all(20),
                child: RaisedButtonWidget(
                    btnTxt: Constants.BECOME_A_MEMBER,
                    onPressed: () => navigateTo(FlashCardPage()),
                    color: Colors.red[800]),
              )
            ],
          ),
        ));
  }

  FittedBox buildFittedBox() {
    return FittedBox(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          createCard("Buch", "Book"),
          createCard("Wasser", "Water"),
        ],
      ),
    );
  }

  Card createCard(String word, String translation) {
    return Card(
      color: Colors.yellow,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // UserImage(),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "$word",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              // textDirection: TextDirection.rtl,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Transform.scale(
                  scale: 2.0,
                  child: Checkbox(
                    value: false,
                    onChanged: (bool value) {},
                  )),
              Transform.scale(
                  scale: 2.0,
                  child: Checkbox(
                    value: false,
                    onChanged: (bool value) {},
                  )),
              Transform.scale(
                  scale: 2.0,
                  child: Checkbox(
                    value: false,
                    onChanged: (bool value) {},
                  )),
              Transform.scale(
                  scale: 2.0,
                  child: Checkbox(
                    value: false,
                    onChanged: (bool value) {},
                  )),
              Transform.scale(
                  scale: 2.0,
                  child: Checkbox(
                    value: false,
                    onChanged: (bool value) {},
                  )),
              Transform.scale(
                  scale: 2.0,
                  child: Checkbox(
                    value: false,
                    onChanged: (bool value) {},
                  )),
              Transform.scale(
                  scale: 2.0,
                  child: Checkbox(
                    value: false,
                    onChanged: (bool value) {},
                  )),
              Transform.scale(
                  scale: 2.0,
                  child: Checkbox(
                    value: false,
                    onChanged: (bool value) {},
                  )),
            ],
          )
        ],
      ),
    );
  }

  Widget createBasicInfoSection(String word, String translation) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        // createMatchingIcon(),
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "$word",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              // textDirection: TextDirection.rtl,
            ),
            /*  Text(
              "North East Dallas",
              textDirection: TextDirection.rtl,
            ) */
          ],
        ),
      ],
    );
  }

  Icon createMatchingIcon() {
    return Icon(
      Icons.stars,
      size: 50,
    );
  }

  void nextPage() {
    _pageController.nextPage(
        duration: new Duration(milliseconds: 300), curve: Curves.linear);
  }

  Future<List<User>> getFirst50Cards() async {
    Uri uri = Uri.https(Constants.SERVER_URL, Constants.GET_ALL_USERS);
    DsRequest request = new DsRequest(0, 50);

    http.Response response = await http.post(uri,
        body: json.encode(request.toJson()),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        });

    if (response.statusCode == 200) {
      DataSourceResponse dataSourceResponse =
          DataSourceResponse.fromJson(json.decode(response.body));

      final users =
          dataSourceResponse.response.data.map((i) => new User.fromJson(i));

      List<User> cleanUsers = new List<User>();
      /*    for (User user in users) {
        print(user.id);
      }*/

      /*     users.forEach((user) => cards
          .add(createCard(user.firstName, user.lastName, user.age.toString())));*/

      users.forEach((user) => cleanUsers.add(user));
//      for (User user in users) {
//        cards.add(createCard(user.firstName, user.lastName, user.age.toString()));
//      }
      // registration accepted: go to next page
      print(response.statusCode);
      return cleanUsers;
    } else {
      // user already exists: go to sign in page
      print(response.statusCode);
    }

    return null;
  }

  User _getData(int index) {
    User user = cachedData[index];
    if (user == null) {
      user = new User.withEmailPassword("loading...", "loading...");
    }

    return user;
  }

  Widget createMySelfSummary(String selfSummaryText) {
    return Column(
      children: <Widget>[Text("My self-summary"), Text(selfSummaryText)],
    );
  }

    void navigateTo(Widget page) async {
    // TODO: check whether the age entered is over 18 years.
    bool result = await Navigator.push(
        _context, MaterialPageRoute(builder: (context) => page));
  }
}

class UserImage extends StatelessWidget {
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
