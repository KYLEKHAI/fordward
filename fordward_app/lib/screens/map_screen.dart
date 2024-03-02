import 'package:flutter/material.dart';
import 'package:fordward_app/screens/home.dart';
import 'package:fordward_app/screens/profile_screen.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapState();
}

class _MapState extends State<MapPage> {
  // KEEP TRACK OF SELECTED INDEX
  int _selectedIndex = 1;

// ON TAP FUNCTION
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // SWITCH TO SELECTED SCREEN BASED ON INDEX
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        break;

      // MAP SELECTION
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MapPage()),
        );
        break;

      // PROFILE SELECTION
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF272849),
      body: Center(
        child: Text('Map', style: TextStyle(color: Colors.white)),
      ),

      // BOTTOM NAVIGATION BAR
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF4D5074),

        // SELECTED ITEM STYLES
        selectedItemColor: Color(0xFF6ADED7),
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,

        // BOTTOM NAVIGATION BAR ITEMS
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
