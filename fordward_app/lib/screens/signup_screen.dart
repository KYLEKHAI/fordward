import 'package:flutter/material.dart';
import 'package:fordward_app/screens/title_page.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // MAKE CONTROLLER FOR EMAIL AND PASSWORD TEXTFIELD
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    // SET BUTTON COLOR
    Color buttonColor = Color(0xFF454768);

    return Scaffold(
      backgroundColor: Color(0xFF272849),
      appBar: AppBar(
        // BACK BUTTON
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),

          // GO BACK TO PREVIOUS SCREEN
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            // POSITIONS THE TITLE UP
            top: 20,
            left: 0,
            right: 200,
            child: Center(
              // TITLE TEXT

              // MAKE TITLE MOVE ON TOP
              child: Text(
                "Sign Up",

                // TEXT PROPERTIES
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // NAME TEXTFIELD
          Positioned(
            top: 100,
            left: 20,
            right: 20,
            child: TextField(
              controller: passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                labelText: 'Name',
                filled: true,
                fillColor: Colors.white,
              ),
              style: TextStyle(
                color: Color(0xFFCBCBCB),
              ),

              // HIDDEN PASSWORD INPUT
              obscureText: true,
            ),
          ),

          // EMAIL TEXTFIELD
          Positioned(
              top: 200,
              left: 20,
              right: 20,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Email',
                  filled: true,
                  fillColor: Colors.white,
                ),
                style: TextStyle(
                  color: Color(0xFFCBCBCB),
                ),
                keyboardType: TextInputType.emailAddress,
              )),

          // PASSWORD TEXTFIELD
          Positioned(
            top: 300,
            left: 20,
            right: 20,
            child: TextField(
              controller: passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                labelText: 'Password',
                filled: true,
                fillColor: Colors.white,
              ),
              style: TextStyle(
                color: Color(0xFFCBCBCB),
              ),

              // HIDDEN PASSWORD INPUT
              obscureText: true,
            ),
          ),

          // COMFIRM PASSWORD TEXTFIELD
          Positioned(
            top: 400,
            left: 20,
            right: 20,
            child: TextField(
              controller: confirmPasswordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                labelText: 'Confirm Password',
                filled: true,
                fillColor: Colors.white,
              ),
              style: TextStyle(
                color: Color(0xFFCBCBCB),
              ),

              // HIDDEN PASSWORD INPUT
              obscureText: true,
            ),
          ),
          Positioned(
            // CREATE ACCOUNT BUTTON
            top: 500,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                // GO TO HOME SCREEN
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TitlePage()),
                );
              },

              // BUTTON STYLES
              style: ButtonStyle(
                // SET BUTTON BG COLOR TO HEX AND TEXT TO WHITE
                backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),

              // CENTER BUTTON
              child: Center(child: Text('Create Account')),
            ),
          ),
        ],
      ),
    );
  }
}
