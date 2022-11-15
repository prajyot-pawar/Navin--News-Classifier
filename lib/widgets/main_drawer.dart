import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
        color: Colors.amber[700],
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            child: Container(
              child: Image.network(
                'https://live.staticflickr.com/65535/51945975602_bb90f1af5e_m.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 20),
          buildListTile(
            'Feed',
            Icons.feed,
            () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          buildListTile(
            'Settings',
            Icons.settings,
            () {},
          ),
          buildListTile(
            'Be News',
            Icons.message,
                () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          )
        ],
      ),
    );
  }
}
