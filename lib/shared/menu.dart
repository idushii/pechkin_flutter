import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pechkin_flutter/screens/projects_screen.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 700;

    if (isSmallScreen) {
      return Container(
          width: 50,
          child: Column(children: [
            Container(
              height: 50,
              child: const Center(child: Icon(Icons.menu)),
            ),
            IconButton(
              icon: Icon(Icons.folder_open),
              onPressed: () => context.goNamed(ProjectsScreen.route),
            ),
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () => context.goNamed(ProjectsScreen.route),
            ),
            IconButton(
              icon: Icon(Icons.chat_bubble_outline),
              onPressed: () => context.goNamed(ProjectsScreen.route),
            ),
            IconButton(
              icon: Icon(Icons.people),
              onPressed: () => context.goNamed(ProjectsScreen.route),
            ),
          ]));
    }

    return Container(
      width: 270,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(height: 50, alignment: Alignment.center, child: Text("Меню", style: TextStyle(fontSize: 20))),
        ListTile(
            title: Text("Проекты"),
            trailing: Icon(Icons.chevron_right),
            leading: Icon(Icons.folder_open),
            onTap: () {
              context.goNamed(ProjectsScreen.route);
            }),
        ListTile(
            title: Row(children: [
              Text("Уведомления"),
              Container(
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                  alignment: Alignment.center,
                  height: 20,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text("10", style: TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                  margin: EdgeInsets.only(left: 10))
            ]),
            trailing: Icon(Icons.chevron_right),
            leading: Icon(Icons.notifications),
            onTap: () {
              context.goNamed(ProjectsScreen.route);
            }),
        ListTile(
            title: Text("Обсуждения"),
            trailing: Icon(Icons.chevron_right),
            leading: Icon(Icons.chat_bubble_outline),
            onTap: () {
              context.goNamed(ProjectsScreen.route);
            }),
        ListTile(
            title: Text("Команда"),
            leading: Icon(Icons.people),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              context.goNamed(ProjectsScreen.route);
            }),
      ]),
    );
  }
}
