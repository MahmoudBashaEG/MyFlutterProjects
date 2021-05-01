import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Salle'),
        actions: [
          FaIcon(FontAwesomeIcons.search),
        ],
      ),
      body: Container(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {},
        currentIndex: 3,
        items: [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.th),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.heart),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.cog),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
