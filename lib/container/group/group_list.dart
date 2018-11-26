import 'package:easy_drivers/page/group_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class GroupsCard extends StatelessWidget {

  final Text text;
  final String groupId;
  GroupsCard({@required this.text, @required this.groupId});

  @override
  Widget build(BuildContext context) {
    return new Card(
        child: new Material(
          color: Colors.lightBlueAccent,
          child: new InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GroupPage(groupId: groupId),
                ),
              );
            },
            //onTap: null,
            child: new Padding(
                padding: new EdgeInsets.symmetric(vertical: 15.0, horizontal: 150.0),
                child: text
            ),
          ),
        )
    );
  }
}



class GroupList extends StatelessWidget {

  final String _userUid;
  GroupList(this._userUid);

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: Firestore.instance.collection('users').document(_userUid).collection('groups').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData || _userUid == null) return new Text('Loading...');
        return new ListView(
          children: snapshot.data.documents.map((DocumentSnapshot document) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: new GroupsCard(
                text: Text(document['name']),
                groupId: document.documentID,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}