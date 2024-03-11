import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jamal_shap/components/utils/utils.dart';

import '../../../components/session_controller.dart';
import '../../shopes/dashborad_screen.dart';




class LoginController with ChangeNotifier {
  // Existing code...
  final auth = FirebaseAuth.instance;

  bool _loading = false;
  bool get loading => _loading;

  setloading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }

  void showLowConnectivityMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Internet connection is slow or unavailable.'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void handleLoginFailure(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Login failed due to a network issue.'),
        duration: Duration(seconds: 3),
      ),
    );
  }


  void login(BuildContext context, String email, String password) async {
    try {
      bool isConnected = await checkInternetConnectivity();
      if (!isConnected) {
        showLowConnectivityMessage(context);
        return;
      }

      setloading(true);
      auth.signInWithEmailAndPassword(email: email, password: password).then((value) {
        final user = auth.currentUser;
        setloading(false);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => dashbord()));
        print(user!.uid.toString());
      }).catchError((error) {
        setloading(false);
        // Handle specific error cases (e.g., invalid email or password)
        if (error.code == 'INVALID_LOGIN_CREDENTIALS' || error.code == 'wrong-password') {
          utls.toast('Incorrect email or password');

        }
        else {
           handleLoginFailure(context);
        }
      });
    } catch (e) {
      setloading(false);
      utls.toast(e.toString());
    }
  }

}



