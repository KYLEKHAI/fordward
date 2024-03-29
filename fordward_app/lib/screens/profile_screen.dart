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

  // KEEP TRACK OF SELECTED ITEMS
  List<String> _selectedItems = [];

  // INITIAL SLIDER VALUE
  double _sliderValue = 0.0;

  // VARIABLE FOR CAR MODEL
  String? _carModel;

// FUNCTION TO SHOW DIALOG FOR SELECTING CAR MODEL
  void _showCarModelDialog() async {
    String? tempCarModel = _carModel;
    final String? selectedModel = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Select Car Model'),
              content: Container(
                height: 150.0,
                child: Column(
                  children: <Widget>[
                    RadioListTile<String>(
                      title: const Text('Ford F-150'),
                      value: 'Ford F-150',
                      groupValue: tempCarModel,
                      onChanged: (String? value) {
                        setState(() {
                          tempCarModel = value;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text('Mustang Mach-E'),
                      value: 'Mustang Mach-E',
                      groupValue: tempCarModel,
                      onChanged: (String? value) {
                        setState(() {
                          tempCarModel = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(tempCarModel);
                  },
                ),
              ],
            );
          },
        );
      },
    );

    if (selectedModel != null) {
      setState(() {
        _carModel = selectedModel;
      });
    }
  }

// SHOW SLIDER DIALOG
  void _showSliderDialog() async {
    final double? result = await showDialog<double>(
      context: context,
      builder: (BuildContext context) {
        return SliderDialog(sliderValue: _sliderValue);
      },
    );

    if (result != null) {
      setState(() {
        _sliderValue = result;
      });
    }
  }

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
          "Profile",
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
            SizedBox(height: 15),

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

            SizedBox(height: 20),

            Text(
              "Email",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 15),

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

            SizedBox(height: 25),

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

            SizedBox(height: 15),
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

            SizedBox(height: 15),

            // BUTTON FOR SETTING THRESHOLD ON BATTERY TO CHARGE
            Center(
              child: ElevatedButton(
                onPressed: _showSliderDialog,
                child: Text(
                  'Battery Threshold',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(buttonColor),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  minimumSize: MaterialStateProperty.all<Size>(Size(150, 60)),
                ),
              ),
            ),

            SizedBox(height: 10),

            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: 300,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: buttonColor2,
                  ),
                  child: Center(
                    child: Text(
                      'Current threshold: ${_sliderValue.toStringAsFixed(0)}%',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 10),

            // BUTTON FOR SETTING CAR MODEL
            Center(
              child: ElevatedButton(
                onPressed: _showCarModelDialog,
                child: Text(
                  'Car Model',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(buttonColor),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  minimumSize: MaterialStateProperty.all<Size>(Size(150, 60)),
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

// SLIDER WIDGET

class SliderDialog extends StatefulWidget {
  final double sliderValue;

  SliderDialog({required this.sliderValue});

  @override
  _SliderDialogState createState() => _SliderDialogState();
}

class _SliderDialogState extends State<SliderDialog> {
  late double _tempSliderValue;

  @override
  void initState() {
    _tempSliderValue = widget.sliderValue;
    super.initState();
  }

  void _onCancelTap() {
    Navigator.pop(context);
  }

  void _onSubmitTap() {
    Navigator.pop(context, _tempSliderValue);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Set Battery Threshold'),
      content: Container(
        height: 150.0, // Set the height here
        child: Slider(
          value: _tempSliderValue,
          min: 0,
          max: 100,
          divisions: 100,
          label: _tempSliderValue.round().toString(),
          onChanged: (double value) {
            setState(() {
              _tempSliderValue = value;
            });
          },
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
