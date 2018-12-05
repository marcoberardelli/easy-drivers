import 'package:easy_drivers/page/group_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class GroupsCard extends StatelessWidget {

  final String name;
  final String groupId;
  GroupsCard({@required this.name, @required this.groupId});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Material(
          color: Colors.lightBlueAccent,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GroupPage(groupId: groupId, groupName: name),
                ),
              );
            },
            //onTap: null,
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 150.0),
                child: Text(name)
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
    return StreamBuilder(
      stream: Firestore.instance.collection('users').document(_userUid).collection('groups').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData || _userUid == null) return Text('Loading...');
        return ListView(
          children: snapshot.data.documents.map((DocumentSnapshot document) {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: GroupsCard(
                name: document['name'],
                groupId: document.documentID,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}