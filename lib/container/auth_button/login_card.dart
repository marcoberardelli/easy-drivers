import 'package:flutter/material.dart';


class LoginCard extends StatelessWidget {

  final VoidCallback onPressed;
  final Icon icon;
  final Text text;

  LoginCard({
    @required this.icon,
    @required this.text,
    @required this.onPressed,}
      );

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: new FlatButton(
            onPressed: this.onPressed,
            child: new Container(
              child: new Row(
                children: <Widget>[
                  new Padding(
                    padding: EdgeInsets.only(top: 40.0, left: 30.0, bottom: 40.0),
                    child: this.icon,
                  ),
                  new Expanded(
                    child: new Container(
                        alignment: Alignment.center,
                        child: this.text
                    ),
                  )
                ],
              ),
            )
        )
    );
  }
}