// IMPORT PACKAGES TO INCLUDE PREMADE WIDGETS AND UTILITIES
import 'package:flutter/material.dart';
import 'package:fordward_app/utils/color_utils.dart';
import 'package:fordward_app/screens/signup_screen.dart';
import 'package:fordward_app/screens/signin_screen.dart';

class TitlePage extends StatefulWidget {
  const TitlePage({super.key});

  @override
  State<TitlePage> createState() => _TitlePageState();
}

class _TitlePageState extends State<TitlePage> {
  @override
  Widget build(BuildContext context) {
    // SET BUTTON COLOR
    Color buttonColor = Color(0xFF454768);

    return Scaffold(
      backgroundColor: Color(0xFF272849),
      body: Stack(
        children: [
          Positioned(
            // POSITIONS THE TITLE UP
            top: 100,
            left: 0,
            right: 0,
            child: Center(
              // TITLE TEXT

              // MAKE TITLE MOVE ON TOP
              child: Text(
                "FORDWARD",

                // TEXT PROPERTIES
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            // SIGN IN BUTTON
            left: 50,
            bottom: 40,
            child: ElevatedButton(
              onPressed: () {
                // GO TO SIGN IN SCREEN
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              },

              // BUTTON STYLES
              style: ButtonStyle(
                // SET BUTTON BG COLOR TO HEX AND TEXT TO WHITE
                backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),

                // SET BUTTON SIZE
                minimumSize: MaterialStateProperty.all<Size>(Size(130, 60)),
              ),
              child: Text('Sign In'),
            ),
          ),
          Positioned(
            // SIGN UP BUTTON
            right: 50,
            bottom: 40,
            child: ElevatedButton(
              onPressed: () {
                // GO TO SIGN UP SCREEN
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },

              // BUTTON STYLES
              style: ButtonStyle(
                // SET BUTTON BG COLOR TO HEX AND TEXT TO WHITE
                backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),

                // SET BUTTON SIZE
                minimumSize: MaterialStateProperty.all<Size>(Size(130, 60)),
              ),

              child: Text('Sign Up'),
            ),
          ),
        ],
      ),
    );
  }
}
