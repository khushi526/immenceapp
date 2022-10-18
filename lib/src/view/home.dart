import 'package:flutter/material.dart';
import 'package:immenceapp/src/view/profile_screen.dart';
import 'package:immenceapp/src/Utils/colors.dart';
import 'package:immenceapp/src/view/user_screen.dart';

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
        selectedItemColor: ThemeColors.primaryColor,
        unselectedItemColor: ThemeColors.unselectedColor,
        onTap: _onClicked,
        elevation: 5,
      ),
    );
  }
}
