
import 'package:flutter/material.dart';
import 'package:jamal_shap/components/utils/utils.dart';
import 'package:jamal_shap/view_moduls/authentications/signup/signup_controller/signup_controller.dart';
import 'package:provider/provider.dart';


import '../../../components/componen/input_textfield.dart';
import '../../../components/componen/round_button.dart';



class signupscreen extends StatefulWidget {
  const signupscreen({Key? key}) : super(key: key);

  @override
  State<signupscreen> createState() => _signupscreenState();
}

class _signupscreenState extends State<signupscreen> {
  final form = GlobalKey<FormState>();
  final emaicontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final username = TextEditingController();
  final usernamefocus = FocusNode();
  final emailfocus = FocusNode();
  final passwordf = FocusNode();
  final pnumbercontroller = TextEditingController();
  final addresscontroller = TextEditingController();
  final phnumberfocus = FocusNode();
  final addresfocus = FocusNode();
  final profilecontroller = TextEditingController();
  final profilefocus = FocusNode();
  void dispose(){
    emailfocus.dispose();
    passwordf.dispose();
    emaicontroller.dispose();
    passwordcontroller.dispose();
    usernamefocus.dispose();
    username.dispose();

  }

  void initState() {
    // TODO: implement initState



  }
  @override

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height*1;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(

        child: ChangeNotifierProvider(
          create: (_)=>signup_controller(),
          child: Consumer<signup_controller>(builder: ( context, provider, child)
          {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Join Now For Free', style: Theme.of(context).textTheme.headline2,
                  ),


                  SizedBox(height: height*0.1,),
                  Form( key:  form,
                      child: Column(
                        children: [
                          textfield(
                            icon: Icon(Icons.account_circle_rounded, color: Colors.black,),

                            mycontroller: username,

                            fieldSetter: (value){
                              utls.filedfocus(context, emailfocus, passwordf);
                            },
                            keyBoradtype: TextInputType.emailAddress,
                            obscureText: false,
                            hint: "Username",
                            fieldValidator: (value){
                              return value.isEmpty ? 'enter username': null;
                            }, focusNode: usernamefocus, label: 'Username',

                          ),
                          SizedBox(height: height*0.01,),
                          textfield(

                            icon: Icon(Icons.email_outlined, color: Colors.black,),

                            mycontroller: emaicontroller,
                            focusNode: emailfocus,
                            fieldSetter: (value){

                            },
                            keyBoradtype: TextInputType.emailAddress,
                            obscureText: false,
                            hint: "Email",
                            fieldValidator: (value)
                            {
                              return value.isEmpty ? 'enter email': null;

                            }, label: 'Email',

                          ),
                          SizedBox(height: height*0.01,),
                          textfield(
                            icon: Icon(Icons.lock_open, color: Colors.black,),

                            mycontroller: passwordcontroller,
                            focusNode: passwordf,
                            fieldSetter: (value){

                            },
                            keyBoradtype: TextInputType.visiblePassword,
                            obscureText: true,
                            hint: "Password",
                            fieldValidator: (value)=>PasswordStrength.validate(value), label: 'Password',

                          ),
                          SizedBox(height: height*0.01,),
                          textfield(

                            icon: Icon(Icons.phone, color: Colors.black,),

                            mycontroller: pnumbercontroller,
                            focusNode: phnumberfocus,
                            fieldSetter: (value){

                            },
                            keyBoradtype: TextInputType.number,
                            obscureText: false,
                            hint: "03311111111",
                            fieldValidator:  (value)=>

                                PasswordStrengthValidator.validate(value!),


                            label: 'Phone',

                          ),
                          SizedBox(height: height*0.01,),
                          textfield(

                            icon: Icon(Icons.maps_home_work_outlined, color: Colors.black,),

                            mycontroller: addresscontroller,
                            focusNode: addresfocus,
                            fieldSetter: (value){

                            },
                            keyBoradtype: TextInputType.text,
                            obscureText: false,
                            hint: "Address",
                            fieldValidator: (value){
                              return value.isEmpty ? 'enter address': null;

                            }, label: 'Address',

                          ),
                        ],
                      )
                  ),

                  SizedBox(height: height*0.04,),
                  ElevatedButton(child: Text('SignUp'),


                    onPressed: () {
                      if(form.currentState!.validate()){
                        provider.signup(context,username.text.toString(),
                            emaicontroller.text.toString(),
                            passwordcontroller.text.toString(),
                            pnumbercontroller.text.toString(),
                            addresscontroller.text.toString(),
                            profilecontroller.text.toString(),


                        );
                      }
                    },
                  ),






                ],
              ),
            );
          },


          ),
        ),
      ),
    );
  }
}
class PasswordStrengthValidator {
  static String? validate(String value) {
    if (value.isEmpty) {
      return 'enter number';
    }

    if (value.length < 11) {
      return 'the number is too short';
    }
    if (value.length < 11) {
      return 'the number is too short';
    }





    return null; // Return null if the password is valid
  }
}
class PasswordStrength {
  static String? validate(String value) {
    if (value.isEmpty) {
      return 'enter password';
    }

    if (value.length < 6) {
      return 'the password is too short';
    }





    return null; // Return null if the password is valid
  }
}


