import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_drivers/container/group/content_group_code.dart';
import 'package:easy_drivers/model/app_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class CreateGroupPage extends StatefulWidget {

  @override
  CreateGroupState createState() => new CreateGroupState();
}

class CreateGroupState extends State<CreateGroupPage> {

  final formKey = new GlobalKey<FormState>();
  String _groupCode = '';

  void _validate() {
    final form = formKey.currentState;
    if(form.validate()) {
      form.save();
    }
  }

  void _createGroup(String groupName, BuildContext context, FirebaseUser user) async {

    Firestore store = Firestore.instance;
    Map<String, dynamic> groupMap =
    {
      'name' : groupName,
      'logs' : [],
      'owner' : user.uid,
      'members' : [user.uid,],
    };
    Map<String, dynamic> userMap = {
      'name' : user.displayName,
      'email' : user.email,
      'data' : {
        'absent' : 0,
        'driven' : 0,
        'not_driven' : 0
      }
    };
    DocumentReference groupRef;
    await store.runTransaction((Transaction tx) async {
      groupRef = await store.collection('groups').add(groupMap);
      await tx.set(groupRef, groupMap);
    });
    await store.runTransaction((Transaction tx) async {
      DocumentReference userRef = groupRef.collection('users').document(user.uid);
      await tx.set(userRef, userMap);
    });
    await store.runTransaction((Transaction tx) async  {
      DocumentReference ref = store.collection('users').document(user.uid).collection('groups').document(groupRef.documentID);
      Map<String, dynamic> temp = {
        'name' : groupName,
      };
      await tx.set(ref, temp);
    });

    setState(() {
      _groupCode = groupRef.documentID;
    });
  }

  @override
  Widget build(BuildContext context) {


    return StoreConnector<AppState, _ViewModel>(
    converter: _ViewModel.fromStore,
    builder: (BuildContext context, _ViewModel vm) {
      return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("Create a group"),
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Form(
                key: formKey,
                child: TextFormField(
                  decoration: InputDecoration(labelText: "Group name"),
                  validator: (value) => value.isEmpty ? "Group can\'t be empty" : null,
                  onSaved: (val) => _createGroup(val, context, vm.user),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(50.0),
                child: RaisedButton(
                  padding: EdgeInsets.all(20.0),
                  child: Text("Create group"),
                  onPressed: _validate,
                ),
              ),
              ContentGroupCode(_groupCode)
            ],
          ),
        ),
      );
    });
  }
}

class _ViewModel {
  final FirebaseUser user;

  _ViewModel({this.user});

  static _ViewModel fromStore(Store<AppState> store) {

    return new _ViewModel(
      user: store.state.currentUser,
    );

  }

}