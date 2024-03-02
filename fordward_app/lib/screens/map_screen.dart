import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fordward_app/screens/home.dart'; // Assuming you have a HomeScreen widget
import 'package:fordward_app/screens/profile_screen.dart'; // Assuming you have a ProfilePage widget
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

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
      case 1:
        // Do nothing, we're already on MapPage
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue, // Set the primary color to blue
      ),
      home: Scaffold(
        backgroundColor: Color(0xFF272849),
        body: Stack(
          children: [
            MapBackground(),
            Positioned(
              bottom: 50.0,
              left: 10.0,
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled:
                          true, // Set to true to cover the entire width of the screen
                      builder: (BuildContext context) {
                        return Container(
                          height: 500,
                          width:
                              2000, // Set width to cover the entire width of the screen
                          child: Column(
                            children: [
                              TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search...',
                                  prefixIcon: Icon(Icons.search),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: 20, // Adjust as needed
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text('Item $index'),
                                      onTap: () {
                                        // Handle item tap
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF272849),
                    shape: CircleBorder(),
                    padding: EdgeInsets.zero,
                  ),
                  child: Icon(Icons.add,
                      color: Colors.white), // Display "+" icon in yellow
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xFF4D5074),
          selectedItemColor: Color(0xFF6ADED7),
          unselectedItemColor: Colors.white,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
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
      ),
    );
  }
}

class MapBackground extends StatefulWidget {
  @override
  _MapBackgroundState createState() => _MapBackgroundState();
}

class _MapBackgroundState extends State<MapBackground> {
  late GoogleMapController mapController;
  LatLng? currentLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: currentLocation ?? LatLng(0, 0), // Use current location if available, else set to default
        zoom: 14,
      ),
      onMapCreated: (GoogleMapController controller) {
        mapController = controller;
      },
      myLocationEnabled: true,
    );
  }
}
