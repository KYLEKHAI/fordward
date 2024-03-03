import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fordward_app/screens/home.dart'; 
import 'package:fordward_app/screens/profile_screen.dart'; 
import 'package:geolocator/geolocator.dart';
import 'package:google_place/google_place.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapState();
}

class _MapState extends State<MapPage> {
  int _selectedIndex = 1;
  late GooglePlace googlePlace;
  late TextEditingController _searchController;
  List<AutocompletePrediction> _searchResults = [];

  @override
  void initState() {
    super.initState();
    googlePlace = GooglePlace("AIzaSyBGNf2LpsgYGANiFn1Erm_a4c-A9p0GN7M");
    _searchController = TextEditingController(); // Initialize the controller
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() async {
    // Delay to avoid too many API requests while typing
    await Future.delayed(Duration(milliseconds: 300));
    _searchPlaces(_searchController.text);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

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

  Future<void> _searchPlaces(String query) async {
    if (query.isNotEmpty) {
      final result = await googlePlace.autocomplete.get(query);
      if (result != null && result.predictions != null) {
        setState(() {
          _searchResults = result.predictions!;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return Container(
                          height: 500,
                          width: double.infinity,
                          child: Column(
                            children: [
                              TextField(
                                key: Key('search_field'), // Add key
                                controller: _searchController,
                                decoration: InputDecoration(
                                  hintText: 'Search...',
                                  prefixIcon: Icon(Icons.search),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: _searchResults.length,
                                  itemBuilder: (context, index) {
                                    var place = _searchResults[index];
                                    return ListTile(
                                      title: Text(place.description!),
                                      onTap: () {
                                        // Handle selection of place
                                        Navigator.pop(context, place);
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
                  child: Icon(Icons.add, color: Colors.white),
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
        target: currentLocation ?? LatLng(0, 0),
        zoom: 14,
      ),
      onMapCreated: (GoogleMapController controller) {
        mapController = controller;
      },
      myLocationEnabled: true,
    );
  }
}
