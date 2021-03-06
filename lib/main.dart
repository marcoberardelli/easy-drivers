import 'package:easy_drivers/middleware/auth_middleware.dart';
import 'package:easy_drivers/page/add_group.dart';
import 'package:easy_drivers/page/add_ride.dart';
import 'package:easy_drivers/page/create_group.dart';
import 'package:easy_drivers/page/root_page.dart';
import 'package:easy_drivers/page/select_user.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:easy_drivers/model/app_state.dart';
import 'package:easy_drivers/reducer/app_reducer.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final String title = 'Easy Drivers';
  final store = new Store<AppState>(
    appReducer,
    initialState: AppState(),
    middleware: []..addAll(createAuthMiddleware())
  );

  @override
  Widget build(BuildContext context) {

    return StoreProvider(
      store: store,
      child: MaterialApp(
          title: title,
          routes: <String, WidgetBuilder>{
            '/': (BuildContext context) => RootPage(),
            '/create_group': (BuildContext context) => CreateGroupPage(),
            '/add_group': (BuildContext context) => AddGroupPage(),
            //'/add_ride': (BuildContext context) => AddRidePage(),
            '/group': (BuildContext context) => null, //TODO:
          },
          //home: RootPage()
      )
    );
  }
}