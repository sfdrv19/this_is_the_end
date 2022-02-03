import 'package:flutter/material.dart';

Widget navDrawer(context) => Drawer(
  child: ListView(
    children: [
      DrawerHeader(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            SizedBox(
              height: 100,
              child: Image(
                  image: AssetImage('assets/flutter-logo.png')),
            ),
          ],
        ),
      ),
      ListTile(
        leading: const Icon(Icons.arrow_back_sharp),
        title: const Text('На вход'),
        onTap: () {
          Navigator.pushNamed(context, '/');
        },
      ),
      ListTile(
        leading: const Icon(Icons.library_books),
        title: const Text('Список пользователей'),
        onTap: () {
          Navigator.pushNamed(context, '/second');
        },
      ),
    ],
  ),
);