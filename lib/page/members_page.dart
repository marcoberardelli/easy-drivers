import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MembersPage extends StatelessWidget {

  final String groupId;
  MembersPage({this.groupId});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Members"),
      ),
      body: Container(
        child: StreamBuilder(
          stream: Firestore.instance.collection('groups').document(groupId).collection('users').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData || groupId == null) return Text('Loading...');
            return ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: MemberCard(
                    name: document.data['name'],
                    email: document.data['email'],
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}

class MemberCard extends StatelessWidget {

  final String name;
  final String email;
  MemberCard({@required this.name, @required this.email});

/*
  ListTile tile;
  void _getUserInfo() async {

    tile = ListTile(
      title: Text(name),
      subtitle: Text(email),
    );
  }
*/
  @override
  Widget build(BuildContext context) {


    return Card(
      //child: Text(username),
      child: ListTile(
        title: Text(name),
        subtitle: Text(email),
      ),
    );
  }

}