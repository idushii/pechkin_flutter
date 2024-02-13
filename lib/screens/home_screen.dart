import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pechkin_flutter/screens/projects_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const route = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Главная"),
        ),
        body: SafeArea(
            child: Column(children: [
          ListTile(
              title: Text("Проекты"),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).pushNamed(ProjectsScreen.route, arguments: 1);
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
              onTap: () {
                Navigator.of(context).pushNamed(ProjectsScreen.route, arguments: 1);
              }),
          ListTile(
              title: Text("Обсуждения"),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).pushNamed(ProjectsScreen.route, arguments: 1);
              }),
          ListTile(
              title: Text("Команда"),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).pushNamed(ProjectsScreen.route, arguments: 1);
              }),
        ])));
  }
}
