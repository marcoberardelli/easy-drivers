import 'package:flutter/material.dart';

class AddRidePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Ride"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Card(
                  elevation: 8.0,
                  child: Column(
                    children: <Widget>[
                      Text("Insert length:"),
                      Row(
                        children: <Widget>[
                          Text("1234"),
                          Text("Km"),
                        ],
                      ),
                      RaisedButton(
                        child: Text("Select"),
                        onPressed: null,
                      ),
                    ],
                  ),
                ),
                CustomRun(),
              ],
            ),
          ),
          Expanded(
            child: Container(),
          ),
          FlatButton(
            color: Colors.blueGrey,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30.0),
              child: SizedBox(
                width: double.infinity,
                child: Text("ADD CUSTOM RUN",
                  textAlign: TextAlign.center,),
              ),
            ),
            onPressed: ()=>{},
          )
        ],
      )
    );
  }
}

class CustomRun extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => print("asds"),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text("Run Name"),
              Text("1234 km"),
            ],
          ),
        )
      ),
    );
  }
}