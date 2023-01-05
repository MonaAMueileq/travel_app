import 'package:flutter/material.dart';
import 'package:travel_app/screens/filters_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  ListTile buildListTile(String title, IconData icon, VoidCallback onTapLink) {
    return ListTile(
      leading: Icon(
        icon,
        size: 30,
        color: Colors.blue,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Prompt',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onTapLink,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            padding: const EdgeInsets.only(top: 40),
            alignment: Alignment.center,
            color: Colors.orangeAccent,
            child: Text(
              'Tourist Gide',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          buildListTile('Trips', Icons.card_travel, () {
            Navigator.of(context).pushNamed('/');
          }),
          buildListTile('Filtering', Icons.filter_list, () {
            Navigator.of(context).pushNamed(FiltersScreen.screenRoute);
          }),
        ],
      ),
    );
  }
}
