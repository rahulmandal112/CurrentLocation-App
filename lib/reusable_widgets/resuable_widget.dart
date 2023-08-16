import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

TextField reuableTextField(String text,IconData icon,bool isPasswordType,TextEditingController controller)
{
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(icon,color: Colors.white70,),
      labelText: text,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(38.0),
        borderSide: const BorderSide(width: 0,style: BorderStyle.none)
      )
    ),
    keyboardType: isPasswordType?TextInputType.visiblePassword:TextInputType.emailAddress,
  );
}
Container signInSignUpButton(BuildContext context,bool isLogin,Function onTap)
{
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    child: ElevatedButton(
      onPressed:(){ onTap();},
      child: Text(
        isLogin?'LOG IN':'SIGN UP',

      ),
    ),
  );
}