import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fordward_app/screens/map_screen.dart';
import 'package:fordward_app/screens/profile_screen.dart';
import 'package:flip_card/flip_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // KEEP TRACK OF SELECTED INDEX
  int _selectedIndex = 0;

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
    // SET BUTTON COLOR
    Color buttonColor = Color(0xFF454768);
    Color buttonColor2 = Color(0xFF44C77D);

    return Scaffold(
      backgroundColor: Color(0xFF272849),

      appBar: AppBar(
        // REMOVE AUTO BACK ARROW
        automaticallyImplyLeading: false,

        title: Text(
          "My Dashboard",
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            GridTile(
              child: Container(
                color: Color(0xFF272849),
                child: FlipCard(
                  direction: FlipDirection.HORIZONTAL,
                  front: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Color(0xFF6ADED7), width: 5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.battery_charging_full,
                            color: Colors.green, size: 50.0),
                        SizedBox(height: 20.0),
                        Text('Battery Level', style: TextStyle(fontSize: 20.0)),
                        Text('Ex: 87%', style: TextStyle(fontSize: 20.0)),
                      ],
                    ),
                  ),
                  back: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Color(0xFF6ADED7), width: 5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.timer, color: Colors.brown, size: 50.0),
                          SizedBox(height: 20.0),
                          Text('Hours Left Until Charge Needed',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 17.0)),
                          Text('Ex: 5 hours', style: TextStyle(fontSize: 18.0)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GridTile(
              child: Container(
                color: Color(0xFF272849),
                child: FlipCard(
                  direction: FlipDirection.HORIZONTAL,
                  front: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Color(0xFF6ADED7), width: 5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.speed, size: 50.0),
                        SizedBox(height: 20.0),
                        Text('Speedometer', style: TextStyle(fontSize: 20.0)),
                        Text('Ex: 80 KM', style: TextStyle(fontSize: 20.0)),
                      ],
                    ),
                  ),
                  back: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Color(0xFF6ADED7), width: 5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.thermostat_outlined,
                              size: 50.0, color: Colors.pink[100]),
                          SizedBox(height: 20.0),
                          Text('Weather',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20.0)),
                          Text('Ex: 20°C', style: TextStyle(fontSize: 20.0)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GridTile(
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.bluetooth, size: 50.0, color: Colors.blue),
                    Text('Bluetooth',
                        style: TextStyle(fontSize: 20.0),
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
            GridTile(
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.report_problem,
                        size: 50.0, color: Colors.orange),
                    Text('Vehicle Health',
                        style: TextStyle(fontSize: 20.0),
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
            GridTile(
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.group, size: 50.0, color: Colors.red),
                    Text('Group Listening',
                        style: TextStyle(fontSize: 20.0),
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
            GridTile(
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.ev_station, size: 50.0, color: Colors.purple),
                    Text('Nearest Charging Stations',
                        style: TextStyle(fontSize: 20.0),
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
          ],
        ),
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
