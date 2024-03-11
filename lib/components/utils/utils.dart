
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';



class utls {

  static  void filedfocus(BuildContext context, FocusNode currentFocus, FocusNode nextFocus){
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
  static void toast(String message){
    Fluttertoast.showToast(msg: message,
      backgroundColor: Colors.green,
      textColor: Colors.black38,
      fontSize: 16,
    );

  }
}