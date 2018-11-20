import 'package:flutter/material.dart';

enum MenuAction {
  changeName,
  leave,
}

class MenuItem {
  final MenuAction action;
  final String title;
  const MenuItem({@required this.action, @required this.title});
}

class Group extends StatelessWidget {

  final String groupId;

  Group({@required this.groupId});

  final List<MenuItem> choices = const <MenuItem>[
    const MenuItem(title: 'Change name', action: MenuAction.changeName),
    const MenuItem(title: 'Leave group', action: MenuAction.leave),
  ];

  void _selectMenu(MenuAction action) async {
    switch (action) {
      case MenuAction.changeName:
      // TODO:
      // TODO: logs
        break;
      case MenuAction.leave:
      // TODO:
      // TODO: logs
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            PopupMenuButton<MenuAction>(
              onSelected: _selectMenu,
              itemBuilder: (BuildContext context) {
                return choices.map((MenuItem item) {
                  return PopupMenuItem<MenuAction>(
                    value: item.action,
                    child: Text(item.title),
                  );
                }).toList();
              },
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.calendar_today)),
              Tab(icon: Icon(Icons.info)),
            ],
          ),
          title: Text(groupId),
        ),
        body: TabBarView(
          children: [
            Scaffold(
              floatingActionButton: FloatingActionButton(
                child: new Icon(Icons.add),
                tooltip: "New Group",
                onPressed: () {},
              ),
              body: Container(),
            ),
            Icon(Icons.info),
          ],
        ),
      ),
    );
  }
}
