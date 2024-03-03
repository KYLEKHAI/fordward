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
  String? selectedAddress;
  PersistentBottomSheetController? _bottomSheetController;

  @override
  void initState() {
    super.initState();
    googlePlace = GooglePlace("YOUR_API_KEY_HERE");
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Page'),
      ),
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
                  if (_bottomSheetController != null) {
                    _bottomSheetController!.close();
                  }
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 500,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xFF272849),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 20),
                                  Text(
                                    'From: Current Location',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    'To: $selectedAddress',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context); // Close the current bottom sheet
                                      _showSearchModal(); // Show the search modal
                                    },
                                    child: Text('Back'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ).then((value) {
                    _bottomSheetController = value;
                  });
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
    );
  }

  void _showSearchModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: 500,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Added padding
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)), // Rounded top corners
          ),
          child: Column(
            children: [
              TextField(
                key: Key('search_field'), // Add key
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search, color: Colors.black), // Icon color
                  border: OutlineInputBorder( // Added border
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true, // Fill color
                  fillColor: Color(0xFFE0E0E0), // Fill color
                  contentPadding: EdgeInsets.symmetric(horizontal: 15), // Padding
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    var place = _searchResults[index];
                    return ListTile(
                      title: Text(
                        place.description!,
                        style: TextStyle(color: Colors.black), // Text color
                      ),
                      onTap: () {
                        // Handle selection of place
                        selectedAddress = place.description!;
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
  }
}

class MapBackground extends StatefulWidget {
  @override
  _MapBackgroundState createState() => _MapBackgroundState();
}

class _MapBackgroundState extends State<MapBackground> {
  late GoogleMapController mapController;
  LatLng? currentLocation;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
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
      markers: _markers,
    );
  }
}
