import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_drivers/model/app_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';


class AddGroupPage extends StatefulWidget {

  @override
  AddGroupPageState createState() => AddGroupPageState();
}

class AddGroupPageState extends State<AddGroupPage> {

  final formKey = new GlobalKey<FormState>();
  final myController = TextEditingController();
  String formValidator;


  void _validate(FirebaseUser user) async {

    String response;

    if(myController.text.isEmpty){
      response = "Group code can\'t be empty";
    } else {
      await Firestore.instance.collection('groups').document(myController.text).get()
        .then((snap) {
          if(!snap.exists) {
            response = "Group doesn\'t exists";
          }
        });
    }
    setState(() {
      this.formValidator = response;
      print(formValidator);
    });

    if (formKey.currentState.validate()) {
      _addGroup(user, myController.text);
    }
  }


  void _addGroup(FirebaseUser user, String groupCode) {
    print("Group CODE in _addGroup(): $groupCode");
    //Firestore firestore = Firestore.instance;
    /*
    await firestore.runTransaction((Transaction tx) async {
      DocumentReference ref = firestore.collection('groups').document(
          groupCode);
      DocumentSnapshot snapshot = await tx.get(ref);
      //TODO: check if is tx.set or tx.update

    });
    */
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (BuildContext context, _ViewModel vm) {
        return new Scaffold(
            resizeToAvoidBottomPadding: false,
            appBar: new AppBar(
              title: new Text("Add a group"),
            ),
            body: new Container(
              padding: EdgeInsets.all(20.0),
              child: new Column(
                children: <Widget>[
                  new Form(
                      key: formKey,
                      child: new TextFormField(
                        controller: myController,
                        decoration: new InputDecoration(
                            labelText: "Group code"),
                        validator: (val) {
                          return this.formValidator;
                        },
                      )
                  ),
                  new Padding(
                    padding: EdgeInsets.all(50.0),
                    child: new RaisedButton(
                      padding: EdgeInsets.all(20.0),
                      child: new Text("Add Group"),
                      onPressed: () => _validate(vm.user),
                    ),
                  ),
                ],
              ),
            )
        );
      },
    );
  }
}



class _ViewModel {

  FirebaseUser user;

  _ViewModel({this.user});


  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(user: store.state.currentUser);
  }
}