import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class ContentGroupCode extends StatelessWidget {

  final String groupCode;
  ContentGroupCode(this.groupCode);


  @override
  Widget build(BuildContext context) {
    if (groupCode == '') {
      return new Text("");
    }
    return new Column(
      children: <Widget>[
        new Padding(
            padding: EdgeInsets.all(20.0),
            child: new Text("Group code:")
        ),
        new Padding(
          padding: EdgeInsets.all(20.0),
          child: new Text(groupCode),
        ),
        new RaisedButton(
          child: new Text("Copy"),
          onPressed: () {
            Clipboard.setData(new ClipboardData(text: groupCode));
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}