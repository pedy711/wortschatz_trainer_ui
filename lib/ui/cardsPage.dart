import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wortschatz_trainer/models/FlashCard.dart';
import 'package:wortschatz_trainer/models/communication/dataSourceResponse.dart';
import 'package:wortschatz_trainer/models/communication/dsRequest.dart';
import 'package:wortschatz_trainer/models/communication/dsResponse.dart';
import 'package:wortschatz_trainer/models/user.dart';
import 'package:wortschatz_trainer/shared/constants.dart';
import 'package:http/http.dart' as http;

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
  List<Padding> cards = new List<Padding>();
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

  Padding createCard(String word, String translation) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Card(
        child: ListView(
          children: <Widget>[
            // UserImage(),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  createBasicInfoSection(word, translation),
                  Divider(),
                ],
              ),
            )
          ],
        ),
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
              "$word $translation",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              // textDirection: TextDirection.rtl,
            ),
            Text(
              "North East Dallas",
              textDirection: TextDirection.rtl,
            )
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

  @override
  Widget build(BuildContext context) {
    _context = context;

    _pageView = new PageView.builder(
      controller: _pageController,
      itemCount: _cards.length,
      itemBuilder: (BuildContext context, int index) {
        if (index < _cards.length) {
          return createCard(
              _cards.elementAt(index).word,
              _cards.elementAt(index).translation);
              // _cards.elementAt(index).age.toString());
//          return cards != null ? cards : Padding(child: Text("Loading"));
        } else {
          User user = _getData(index);
          return new ListTile(
            title: new Text(user.firstName),
          );
        }
      },
    );

    return new Scaffold(
      backgroundColor: Colors.tealAccent,
      body: _pageView,
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
