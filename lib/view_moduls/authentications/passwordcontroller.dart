

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jamal_shap/components/utils/utils.dart';
import 'package:jamal_shap/view_moduls/authentications/login/login_screen.dart';




class passwordcontoller with ChangeNotifier{

  final auth = FirebaseAuth.instance;

  bool _loading = false;
  bool get loading => _loading;

  setloading(bool value){
    _loading = value;
    notifyListeners();
  }
  void resetpassword( BuildContext context, String email)async{
    try{
      setloading(true);
      auth.sendPasswordResetEmail(email: email)


          .then((value) {
        utls.toast('check your email');

        setloading(false);

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>loginscreen()));




      }).onError((error, stackTrace){
        setloading(false);
        utls.toast(error.toString());
      });

    }
    catch(e){
      setloading(false);
      utls.toast(e.toString());
    }
  }


}