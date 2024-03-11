

//import 'package:firebasenotification/view/forgotpassword/passwordcontroller.dart';
import 'package:flutter/material.dart';
import 'package:jamal_shap/view_moduls/authentications/passwordcontroller.dart';
import 'package:provider/provider.dart';

import '../../components/componen/input_textfield.dart';
import '../../components/componen/round_button.dart';



class forgotpasswprd extends StatefulWidget {
  const forgotpasswprd({Key? key}) : super(key: key);

  @override
  State<forgotpasswprd> createState() => _forgotpasswprdState();
}

class _forgotpasswprdState extends State<forgotpasswprd> {
  final form = GlobalKey<FormState>();
  final emaicontroller = TextEditingController();


  final emailfocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height*1;
    return Scaffold(

      body:
      SafeArea(

        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height*.1,),
              Text('email recovery', style: Theme.of(context).textTheme.headline2,),

              SizedBox(height: height* .1,),
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


                    ],
                  )
              ),

              SizedBox(height: 20,),
              ChangeNotifierProvider(create: (_)=>passwordcontoller(),
                child:  Consumer<passwordcontoller>(builder: (context, provider, child)
                {
                  return              Roundbutton(title: 'Submit', onpress: () {
                    if(form.currentState!.validate()){
                      provider.resetpassword(context, emaicontroller.text.toString());
                    }
                  },
                    loading: provider.loading,);
                }
                ),
              ),






            ],
          ),
        ),
      ),
    );
  }
}
