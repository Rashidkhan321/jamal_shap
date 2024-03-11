import 'package:flutter/material.dart';
import 'package:jamal_shap/components/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../../components/componen/input_textfield.dart';
import '../../../components/componen/round_button.dart';
import '../forgotpassword.dart';
import 'logincontroller.dart';


class loginscreen extends StatefulWidget {
  const loginscreen({Key? key}) : super(key: key);

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  final form = GlobalKey<FormState>();
  final emaicontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  final emailfocus = FocusNode();
  final passwordf = FocusNode();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height*1;
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(

        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30,),
              Container( height: MediaQuery.of(context).size.height*0.3,
                width: MediaQuery.of(context).size.width*0.29,
                child: CircleAvatar(
                  radius: 200,
                  backgroundImage:AssetImage('images/img.png',
                    
                    ),


                ),
              ),

              SizedBox(height: height* .02,),
              Form( key:  form,
                  child: Column(
                    children: [

                      textfield(
                          icon: Icon(Icons.email_outlined, color: Colors.black,),

                          mycontroller: emaicontroller,
                          focusNode: emailfocus,
                          fieldSetter: (value){

                          },
                          keyBoradtype: TextInputType.emailAddress,
                          obscureText: false,
                          hint: "Email",
                          fieldValidator: (value){
                            return value.isEmpty ? 'enter email': null;
                          }, label: 'Email',

                      ),
                      SizedBox(height: height*.010,),

                      textfield(
                          icon: Icon(Icons.lock_open, color: Colors.black,),

                          mycontroller: passwordcontroller,

                         // focusNode:passwordf,
                          fieldSetter: (value){

                          },
                          keyBoradtype: TextInputType.visiblePassword,
                          obscureText: true,
                          hint: "Password",
                          fieldValidator: (value){
                            return value.isEmpty ? 'enter password': null;
                          }, focusNode: passwordf, label: 'Password',

                      ),
                    ],
                  )
              ),

              SizedBox(height: 10,),
   Column(
     children: [
       Padding(
         padding: const EdgeInsets.symmetric(horizontal: 8.0),
         child: Align(
           alignment: Alignment.bottomRight,
           child: TextButton(onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>forgotpasswprd ()));
           }, child: const Text('Forgot Password',style: TextStyle(
             color: Colors.black
           ),)),
         ),
       ),
       ChangeNotifierProvider(create: (_)=> LoginController(),
         child:  Consumer< LoginController>(builder: (context, provider, child)
             {
               return              Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 5.0),
                 child: Roundbutton(
                   textcolor: Colors.white,
                   title: 'Login', onpress: () {
                   if(form.currentState!.validate()){
                     if(emaicontroller.text=='jamal@gmail.com' &&(passwordcontroller.text=='123456')){
                       utls.toast('Incorrect email or password');

                     }else{
                       provider.login(context,  emaicontroller.text.toString(), passwordcontroller.text.toString());
                     }

                   }
                 },
                   loading: provider.loading,),
               );
             }
         ),
       ),

     ],
   ),









            ],
          ),
        ),
      ),
    );
  }

}


