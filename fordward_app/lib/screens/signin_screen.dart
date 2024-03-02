import 'package:flutter/material.dart';
import 'package:fordward_app/utils/color_utils.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(decoration: BoxDecoration(gradient: LinearGradient(colors: [hexStringToColor("##0000ff"), hexStringToColor("##000080"), hexStringToColor("#ADD8E6")], begin: Alignment.topCenter, end: Alignment.bottomCenter)),));
  }
}