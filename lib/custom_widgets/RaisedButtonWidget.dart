import 'package:flutter/material.dart';

class RaisedButtonWidget extends RaisedButton {
  RaisedButtonWidget(
      {Key key, @required this.btnTxt, @required this.onPressed, this.color})
      : super(
            key: key,
            shape: const StadiumBorder(),
            child: Text(
              btnTxt,
              textScaleFactor: 1.2,
              // style: TextStyle(fontWeight: FontWeight.bold),
            ),
            textColor: Colors.white,
            color: color ?? Colors.red[800],
            onPressed: onPressed);

  final GestureTapCallback onPressed;
  final String btnTxt;
  final Color color;

  /* @override
  Widget build(BuildContext context) {
    return RaisedButton(
        /* shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(roundedCorner)), */
        shape: const StadiumBorder(),
        child: Text(
          btnTxt,
          textScaleFactor: 1.2,
          // style: TextStyle(fontWeight: FontWeight.bold),
        ),
        textColor: Colors.white,
        color: this.color ?? Colors.red[800],
        onPressed: this.onPressed);
  } */
}
