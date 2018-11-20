import 'package:flutter/material.dart';
import 'package:easy_drivers/container/auth_button/auth_button_container.dart';


class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Login"),
        ),
        body: new Container(
          //alignment: Alignment.center,
          child: new Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 70.0),
              child: new Column(
                children: <Widget>[
                  new Container(
                    //height: 200.0,
                    child: new Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0))
                        ),
                        color: Colors.white70,
                        child: new Padding(
                          padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
                          child: new Card(
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.black38,
                                    width: 1.0
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(20.0))
                            ),
                            child: new Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new GoogleAuthButtonContainer(),
                                //new Container(
                                //  height: 1.0,
                                //  width: double.infinity,
                                //  color: Colors.black38,
                                //),
                                //new LoginCard(
                                //    icon: Icon(IconData(0xf1a0, fontFamily: 'custom')),
                                //    text: new Text("Login with Google"),
                                //    onPressed: null // TODO:
                                //),
                              ],
                            ),
                          ),
                        )
                    ),
                  ),
                ],
              )
          ),
        )
    );
  }
}


