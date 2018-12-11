import 'package:easy_drivers/page/members_page.dart';
import 'package:easy_drivers/page/select_user.dart';
import 'package:flutter/material.dart';

enum MenuAction {
  changeName,
  leave,
  delete,
  members,
}

class MenuItem {
  final MenuAction action;
  final String title;
  const MenuItem({@required this.action, @required this.title});
}

class GroupPage extends StatelessWidget {

  final String groupId;
  final String groupName;
  GroupPage({@required this.groupId, @required this.groupName});

  final List<MenuItem> choices = const <MenuItem>[
    const MenuItem(title: 'Members', action: MenuAction.members),
    const MenuItem(title: 'Change name', action: MenuAction.changeName),
    const MenuItem(title: 'Leave group', action: MenuAction.leave),
    const MenuItem(title: 'Delete group', action: MenuAction.delete),
  ];

  void _selectMenu(MenuAction action, BuildContext context) async {
    switch (action) {
      case MenuAction.members:
        Navigator.push(context,
          MaterialPageRoute(
            builder: (context) => MembersPage(groupId: groupId),
          )
        );
        // TODO: logs
        break;
      case MenuAction.changeName:
      // TODO:
      // TODO: logs
        break;
      case MenuAction.leave:
      // TODO:
      // TODO: logs
        break;
      case MenuAction.delete:
        // TODO:
        //TODO :logs
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
              onSelected: (action) => _selectMenu(action, context),
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
          title: Text(groupName),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          label: Text("Add run"),
          //onPressed: () => Navigator.pushNamed(context, '/add_ride'),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SelectUser(groupId: groupId),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          //shape: CircularNotchedRectangle(),
          //notchMargin: 4.0,
          /*
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(icon: Icon(Icons.menu), onPressed: (){},),
              IconButton(icon: Icon(Icons.map), onPressed: (){},)
            ],
          ) */
          child: Padding(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.55),
            child: IconButton(icon: Icon(Icons.map), onPressed: (){}),
          ),
        ),
        body: TabBarView(
          children: [
            Scaffold(
              body: Container(),
            ),
            Icon(Icons.info),
          ],
        ),
      ),
    );
  }
}