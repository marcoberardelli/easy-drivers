import 'package:flutter/material.dart';
import 'package:easy_drivers/container/drawer/drawer_container.dart';


class HomePage extends StatelessWidget {

  final int drawerIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("HomePage"),
        ),
      drawer: DrawerContainer(selectedIndex: drawerIndex,),
      body: null,
    );
  }
}