import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_drivers/page/add_ride.dart';
import 'package:flutter/material.dart';

class SelectUser extends StatelessWidget {

  final String groupId;
  SelectUser({@required this.groupId});


  Future<Null> _addRide(BuildContext context, Map<String, String> users) async {

    _Partecipants _partecipants = _Partecipants(groupId: groupId, users: users);

    String driver = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return new SimpleDialog(
          //contentPadding: EdgeInsets.symmetric(vertical: 10.0),
          titlePadding: EdgeInsets.all(20.0),
          title: const Text('Choose the driver'),
          children: <Widget>[
            Container(
              height: _partecipants.users.length * 60.0,
              width: 100.0,
              child: ListView.builder(
                itemCount: _partecipants.users.length,
                itemBuilder: (BuildContext context, int index) {
                  String username = _partecipants.users.values.elementAt(index);
                  //String username = _partecipants.users.keys.elementAt(index);
                  //print(_partecipants.users);
                  return ListTile(
                    title: Text(username),
                    onTap: (){
                      Navigator.pop(context, _partecipants.users.keys.elementAt(index));

                      },
                  );
                },
              ),
            )
          ],
        );
      }
    );
    if(driver != null) {
      Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddRidePage(groupId: groupId),
      ),
    );
    }
  }



  @override
  Widget build(BuildContext context) {
  
    Map<String, String> users = {};

    return Scaffold(
      appBar: AppBar(
        title: Text("Select partecipants"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _addRide(context, users),
        ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.45),
          child: IconButton(icon: Icon(Icons.map), onPressed: (){}),
        ),
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
                  child: _UserTile(
                    users: users,
                    userId: document.documentID,
                    username: document['name'],
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

class _Partecipants {

  String driver;
  final String groupId;
  final Map<String, String> users;

  _Partecipants({@required this.groupId, @required this.users});

}


class _UserTile extends StatefulWidget {

  
  final String username;
  final String userId;
  final Map<String, String> users;
  _UserTile({@required this.username,@required this.userId, @required this.users});
  
  @override
  State<StatefulWidget> createState() => _UserTileState();
}

class _UserTileState extends State<_UserTile> {

  bool selected = false;

  @override
  Widget build(BuildContext context) {
    
    return CheckboxListTile(
      onChanged: (bool value) {
        setState(() {
          selected = value;
          if(value) {
            widget.users[widget.userId] = widget.username;
          } else {
            widget.users.remove(widget.userId);
          }
        });
      }, 
      value: selected,
      title: Text(widget.username),
    );
  }

}