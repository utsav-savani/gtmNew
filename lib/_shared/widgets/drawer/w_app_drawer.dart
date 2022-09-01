import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';

class AppDrawerWeb extends StatefulWidget {
  const AppDrawerWeb({Key? key, required this.userData}) : super(key: key);

  ///logged in user data
  final User userData;

  @override
  State<AppDrawerWeb> createState() => _AppDrawerWebState();
}

class _AppDrawerWebState extends State<AppDrawerWeb> {
  int _selectedDestination = 0;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Header',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Item 1'),
            selected: _selectedDestination == 0,
            onTap: () => selectDestination(0),
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Item 2'),
            selected: _selectedDestination == 1,
            onTap: () => selectDestination(1),
          ),
          ListTile(
            leading: const Icon(Icons.label),
            title: const Text('Item 3'),
            selected: _selectedDestination == 2,
            onTap: () => selectDestination(2),
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Label',
            ),
          ),
          ListTile(
            leading: const Icon(Icons.bookmark),
            title: const Text('Item A'),
            selected: _selectedDestination == 3,
            onTap: () => selectDestination(3),
          ),
        ],
      ),
    );
  }

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }
}
