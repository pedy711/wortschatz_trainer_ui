import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:wortschatz_trainer/models/FlashCard.dart';

class FlashCardPage extends StatefulWidget {
  final List<FlashCard> flashCardsList;
  FlashCardPage({Key key, @required this.flashCardsList}) : super(key: key);

  _FlashCardPageState createState() => _FlashCardPageState();
}

class _FlashCardPageState extends State<FlashCardPage> {
  PageView _pageView = PageView();
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    _pageView = new PageView(
      // children: <Widget>[
      //   buildFlipCard(widget.flashCardsList.elementAt(0)),
      //   buildFlipCard(widget.flashCardsList.elementAt(1))
      // ],
      children: buildAllFlipCards(),
      controller: _pageController,
    );

    return Scaffold(body: _pageView);
  }

  List<FlipCard> buildAllFlipCards() {
    List<FlipCard> allFlipCards = new List<FlipCard>();
    for (var item in widget.flashCardsList) {
      allFlipCards.add(buildFlipCard(item));
    }

    return allFlipCards;
  }

  FlipCard buildFlipCard(FlashCard item) {
    return FlipCard(
      front: buildContainerCard(item.word, false),
      back: buildContainerCard(item.translation, true),
    );
  }

  Padding buildContainerCard(String word, bool isBackSide) {
    return Padding(
      padding: EdgeInsets.all(40),
      child: Center(
          child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            createCard(word),
            if (isBackSide)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  buildRaisedButton(true),
                  buildRaisedButton(false)
                ],
              )
          ],
        ),
      )),
    );
  }

  Card createCard(String word) {
    return Card(
      color: Colors.yellow,
      child: Center(
        heightFactor: 2,
        child: Text(
          "$word",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
        ),
      ),
    );
  }

  RaisedButton buildRaisedButton(bool isTrue) {
    return RaisedButton(
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(5.0)),
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
      child: Icon(
        isTrue ? Icons.check : Icons.clear,
        color: isTrue ? Colors.green : Colors.red,
      ),
      textColor: Colors.white,
      color: Colors.white,
      onPressed: () {nextPage();},
    );
  }

  void nextPage() {
    _pageController.nextPage(
        duration: new Duration(milliseconds: 300), curve: Curves.linear);
  }
}
