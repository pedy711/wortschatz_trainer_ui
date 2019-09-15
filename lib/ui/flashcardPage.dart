import 'package:flutter/material.dart';
import 'package:wortschatz_trainer/shared/constants.dart';
import 'package:flip_card/flip_card.dart';

class FlashCardPage extends StatefulWidget {
  FlashCardPage({Key key}) : super(key: key);

  _FlashCardPageState createState() => _FlashCardPageState();
}

class _FlashCardPageState extends State<FlashCardPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: FlipCard(
          front: buildContainerCard(),
          back: buildContainerCard(),
        ));
  }

  Padding buildContainerCard() {
    return Padding(
          padding: EdgeInsets.all(40),
          child: Center(
              child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                createCard("word", "translation"),
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

  Card createCard(String word, String translation) {
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
      onPressed: () {},
    );
  }
}
