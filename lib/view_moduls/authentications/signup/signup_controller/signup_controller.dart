

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jamal_shap/components/utils/utils.dart';


import '../../../../components/session_controller.dart';
import '../../../shopes/dashborad_screen.dart';



class signup_controller with ChangeNotifier{
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
   final auth = FirebaseAuth.instance;
   final ref = FirebaseFirestore.instance.collection('user');



  // DatabaseReference ref = FirebaseDatabase.instance.ref().child('user');
  bool _loading = false;
  bool get loading => _loading;

  setloading(bool value){
    _loading = value;
    notifyListeners();
  }
  void signup ( BuildContext context,String username, String email, String password,String phoneNumber
      ,String address,String profile,
      )async{
    // bool isConnected = await checkInternetConnectivity();
    // if (!isConnected) {
    //   showLowConnectivityMessage(context);
    //   return;
    // }
 try{
   setloading(true);

   auth.createUserWithEmailAndPassword(

       email: email,
       password: password).then((value){
secssion_controller().uerid = value.user!.uid.toString();
         ref.doc(value.user!.uid.toString()).set({
           'userid':value.user!.uid.toString(),
           'email':value.user!.email.toString(),
           'username':username,
           'phone_number':phoneNumber,
           'address': address,
           'profile': profile,
           'devicetoken':'',
           'latmessage':'lets chat',
           'sender':"",
           'senderreciver':"",
           'emailverfy':'',
           'status':'',
           'adminmessage':'',
           'complant':'',
           'profilebadge':0,
           'contractnotice':0,
           'number':0




         }).then((value) {
           setloading(false);

         Navigator.push(context, MaterialPageRoute(builder: (context)=> dashbord()));

         }).onError((error, stackTrace) {
           utls.toast(error.toString());
         });
         setloading(false);
         utls.toast('user created');

   }).onError((error, stackTrace){
     setloading(false);
       utls.toast('The Email is Badly Formated or The Email is Already in Use');
   });

 }
 catch(e){
   setloading(false);
   utls.toast(e.toString());
 }
  }

}