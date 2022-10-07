import 'package:flutter/material.dart';
import 'package:immenceapp/profile_screen.dart';
import 'package:immenceapp/user_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  static const List<Widget> _selectedwidget = <Widget>[
    UserDetailsScreen(),
    ProfileScreen(),
  ];
  void _onClicked(int indexChoose) {
    setState(() {
      _index = indexChoose;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Center(
        child: _selectedwidget.elementAt(_index),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_outlined),
            label: 'Users',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        type: BottomNavigationBarType.shifting,
        currentIndex: _index,
        selectedItemColor: const Color(0xFF0231C8),
        unselectedItemColor: const Color(0xFF9F9F9F),
        onTap: _onClicked,
        elevation: 5,
      ),
    );
  }
}
