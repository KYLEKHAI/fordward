import 'package:flutter/material.dart';
import 'package:fordward_app/screens/map_screen.dart';
import 'package:fordward_app/screens/home.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
  // KEEP TRACK OF SELECTED INDEX
  int _selectedIndex = 2;

  List<String> _selectedItems = [];

  void _showMultiSelectDialog() async {
    final List<String> _items = [
      "Avoid Highways",
      "Avoid Tolls",
      "Avoid Ferries",
    ];

    final List<String>? results = await showDialog<List<String>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(items: _items, selectedItems: _selectedItems);
      },
    );

    if (results != null) {
      setState(() {
        _selectedItems = results;
      });
    }
  }

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
          "PROFILE",
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Name",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),

            // DISPLAY USER NAME
            Positioned(
              top: 200,
              left: 20,
              right: 20,
              child: TextField(
                // READ ONLY TEXT FIELD
                enabled: false,

                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Display Name',
                  filled: true,
                  fillColor: Colors.white,
                ),
                style: TextStyle(
                  color: Color(0xFFCBCBCB),
                ),
              ),
            ),

            SizedBox(height: 30),

            Text(
              "Email",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 20),

            // DISPLAY USER EMAIL
            Positioned(
              top: 200,
              left: 20,
              right: 20,
              child: TextField(
                // READ ONLY TEXT FIELD
                enabled: false,

                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Display Email',
                  filled: true,
                  fillColor: Colors.white,
                ),
                style: TextStyle(
                  color: Color(0xFFCBCBCB),
                ),
              ),
            ),

            SizedBox(height: 40),

            // MY PREFERENCES BUTTON
            Center(
              child: Theme(
                data: Theme.of(context).copyWith(
                  buttonTheme: ButtonThemeData(
                    buttonColor: buttonColor,
                  ),
                ),
                child: ElevatedButton(
                  onPressed: _showMultiSelectDialog,
                  child: Text(
                    'My Preferences',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  style: ButtonStyle(
                    // SET BUTTON BG COLOR TO HEX AND TEXT TO WHITE
                    backgroundColor:
                        MaterialStateProperty.all<Color>(buttonColor),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),

                    // SET BUTTON SIZE
                    minimumSize: MaterialStateProperty.all<Size>(Size(150, 60)),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),
            // DISPLAY SELECTED PREFERENCES
            Container(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _selectedItems.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: 100,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: buttonColor2,
                      ),
                      child: Center(
                        child: Text(
                          _selectedItems[index],
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
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

// HANDLE MULTISELECT DIALOG LOGIC
class MultiSelectDialog extends StatefulWidget {
  final List<String> items;
  final List<String> selectedItems;

  MultiSelectDialog({required this.items, required this.selectedItems});

  @override
  _MultiSelectDialogState createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<MultiSelectDialog> {
  List<String> _tempSelectedItems = [];

  @override
  void initState() {
    _tempSelectedItems = List.from(widget.selectedItems);
    super.initState();
  }

  void _onItemCheckedChange(String itemValue, bool isChecked) {
    setState(() {
      if (isChecked) {
        _tempSelectedItems.add(itemValue);
      } else {
        _tempSelectedItems.remove(itemValue);
      }
    });
  }

  void _onCancelTap() {
    Navigator.pop(context);
  }

  void _onSubmitTap() {
    Navigator.pop(context, _tempSelectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Map Settings'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items.map((item) {
            return CheckboxListTile(
              title: Text(item),
              value: _tempSelectedItems.contains(item),
              onChanged: (isChecked) => _onItemCheckedChange(item, isChecked!),
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _onCancelTap,
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _onSubmitTap,
          child: Text('Submit'),
        ),
      ],
    );
  }
}
