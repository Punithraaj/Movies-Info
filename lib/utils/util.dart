import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

enum InputBoxType {
    FIRST_NAME,
    LAST_NAME,
    MOBILE_NUM,
    EMAIL,
    PASSWORD
}
class Util {
  // static showToast(String msg){
  //   // if(msg.isNotEmpty) {
  //     Fluttertoast.showToast(
  //         msg: "This is Center Short Toast",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.CENTER,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.red,
  //         textColor: Colors.white,
  //         fontSize: 16.0
  //     );
  //   // }
  // }

  static Shader linearGradient = LinearGradient(
    colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  static String validateMobile(String value) {
    return validateInput(value, InputBoxType.MOBILE_NUM);
  }

  static String validateFirstName(String value) {
    return validateInput(value, InputBoxType.FIRST_NAME);
  }

  static String validateLastName(String value) {
    return validateInput(value, InputBoxType.LAST_NAME);
  }

  static String validateEmail(String value) {
    return validateInput(value, InputBoxType.EMAIL);
  }

  static String validatePassword(String value) {
    return validateInput(value, InputBoxType.PASSWORD);
  }

  static String validateInput(String value, InputBoxType inputBoxType) {
      String msg = 'can\'t be empty.';
      if(InputBoxType.MOBILE_NUM == inputBoxType) {
          if(value.isEmpty){
            return 'Mobile number '+msg;
          }
          if (value.length != 10) {
            return 'Mobile number must be of 10 digits';
          } else {
            return null;
          }
      } else if(InputBoxType.FIRST_NAME == inputBoxType) {
          return value.isEmpty ? 'First name '+msg : null;
      } else if(InputBoxType.LAST_NAME == inputBoxType) {
          return value.isEmpty ? 'Last name '+msg : null;
      } else if(InputBoxType.EMAIL == inputBoxType) {
          return value.isEmpty ? 'Email '+msg : validateEmailFormat(value);
      } else if(InputBoxType.PASSWORD == inputBoxType) {
          return value.isEmpty ? 'Password '+msg : null;
      }
      return null;
  }

  static String validateEmailFormat(String value){
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);
      if(!regex.hasMatch(value)){
        return 'Please enter a valid email';
      }
      return null;
  }
}