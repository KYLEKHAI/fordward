import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fordward_app/screens/home.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // MAKE CONTROLLER FOR EMAIL AND PASSWORD TEXTFIELD
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                "Sign In",

                // TEXT PROPERTIES
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // EMAIL TEXTFIELD
          Positioned(
              top: 100,
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
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                keyboardType: TextInputType.emailAddress,
              )),

          // PASSWORD TEXTFIELD
          Positioned(
            top: 200,
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
                color: Color.fromARGB(255, 0, 0, 0),
              ),

              // HIDDEN PASSWORD INPUT
              obscureText: true,
            ),
          ),
          Positioned(
            // LOGIN BUTTON
            top: 300,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {

                FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text).then((value){
                  // GO TO HOME SCREEN
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                }).onError((error, stackTrace) => null);
                

              },

              // BUTTON STYLES
              style: ButtonStyle(
                // SET BUTTON BG COLOR TO HEX AND TEXT TO WHITE
                backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),

              // CENTER BUTTON
              child: Center(child: Text('Sign In')),
            ),
          ),
        ],
      ),
    );
  }
}
