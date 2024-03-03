import 'package:flutter/material.dart';

//textbox
TextField reuseableTextField(String text, bool isPasswordType, TextEditingController controller){
    return TextField(

    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    keyboardType: isPasswordType
      ? TextInputType.visiblePassword
      : TextInputType.emailAddress,

    );

}