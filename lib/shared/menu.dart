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
      return SizedBox(
          width: 50,
          child: Column(children: [
            const SizedBox(
              height: 50,
              child: Center(child: Icon(Icons.menu)),
            ),
            IconButton(
              icon: const Icon(Icons.folder_open),
              onPressed: () => context.goNamed(ProjectsScreen.route),
            ),
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () => context.goNamed(ProjectsScreen.route),
            ),
            IconButton(
              icon: const Icon(Icons.chat_bubble_outline),
              onPressed: () => context.goNamed(ProjectsScreen.route),
            ),
            IconButton(
              icon: const Icon(Icons.people),
              onPressed: () => context.goNamed(ProjectsScreen.route),
            ),
          ]));
    }

    return SizedBox(
      width: 270,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(height: 50, alignment: Alignment.center, child: const Text("Меню", style: TextStyle(fontSize: 20))),
        ListTile(
            title: const Text("Проекты"),
            trailing: const Icon(Icons.chevron_right),
            leading: const Icon(Icons.folder_open),
            onTap: () {
              context.goNamed(ProjectsScreen.route);
            }),
        ListTile(
            title: Row(children: [
              const Text("Уведомления"),
              Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                  alignment: Alignment.center,
                  height: 20,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text("10", style: TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                  margin: const EdgeInsets.only(left: 10))
            ]),
            trailing: const Icon(Icons.chevron_right),
            leading: const Icon(Icons.notifications),
            onTap: () {
              context.goNamed(ProjectsScreen.route);
            }),
        ListTile(
            title: const Text("Обсуждения"),
            trailing: const Icon(Icons.chevron_right),
            leading: const Icon(Icons.chat_bubble_outline),
            onTap: () {
              context.goNamed(ProjectsScreen.route);
            }),
        ListTile(
            title: const Text("Команда"),
            leading: const Icon(Icons.people),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              context.goNamed(ProjectsScreen.route);
            }),
      ]),
    );
  }
}
