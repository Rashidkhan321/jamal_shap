

//dashbord screen
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jamal_shap/view_moduls/shopes/products/shope_screen.dart';

import '../../components/componen/input_textfield.dart';
import '../../components/componen/round_button.dart';
import '../messages/all_messages_screen.dart';

class dashbord extends StatefulWidget {
  const dashbord({Key? key}) : super(key: key);

  @override
  State<dashbord> createState() => _dashbordState();
}

class _dashbordState extends State<dashbord> {
  final auth = FirebaseAuth.instance;
  final form = GlobalKey<FormState>();
 final currentuser= FirebaseFirestore.instance.collection('user').snapshots();

  @override
  Widget build(BuildContext context) {

    final user = auth.currentUser;
    final userid = auth.currentUser!.uid;
    final height = MediaQuery.of(context).size.height*.9;
    final width = MediaQuery.of(context).size.width*.9;

    return WillPopScope(

      onWillPop: () async {

        return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(

            content: Text('Do you want to exit the app?'),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes'),
              ),
            ],
          ),
        ) ?? false;
      },

      child:Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Dashborad',style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 23
            ),),
          ),

          actions: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Icon(Icons.person)

                ],
              ),
            )
          ],
        ),
        body:

        SingleChildScrollView(
          child: Column(
            children: [

              StreamBuilder<QuerySnapshot>(
                  stream: currentuser,

                  builder: (

                      BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Text('ERROR');
                    }
                    else {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final status = snapshot.data!.docs[index]['status'];
                            if(userid==snapshot.data!.docs[index]['userid']){
                              if(status==''){
                                return Center(
                                  child: Container(
                                    child: Text('No data about this user'),
                                  ),
                                );
                              }
                              else{
                                return Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>shop()));
                                        },
                                        child: Container(
                                          height: height*.15,
                                          width: width,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              color: Colors.black
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Go to Shop', style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 30,
                                                ),),
                                                Icon(Icons.shopping_cart,color: Colors.white,)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 27.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Admin Message',style: TextStyle(
                                              fontSize: 20, fontWeight: FontWeight.w900
                                          ),),
                                          InkWell(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>all_messages()));
                                            },
                                            child: Container(
                                              child: Text('See All',),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: Colors.black, // Color of the line
                                                    width: 2.0, // Width of the line
                                                    style: BorderStyle.solid, // Style of the line
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance.collection('lastmessage').snapshots(),

                                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

                                        if(snapshot.connectionState== ConnectionState.waiting){
                                          return Container();

                                        }
                                        else if(!snapshot.hasData){
                                          return ClipRRect(
                                            borderRadius: BorderRadius.circular(15),
                                            child: InkWell(

                                              child: Container(
                                                height: height*.13,
                                                width: width,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    color: Colors.black38
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Text('New Arrival', style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 30,
                                                          ),),
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                            child: Text('No message yet', style: TextStyle(
                                                                color: Colors.white
                                                            ),),
                                                          ),
                                                        ],
                                                      ),
                                                      Icon(Icons.remove_red_eye,color: Colors.white,)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        else{
                                          return ListView.builder(
                                              shrinkWrap: true,
                                              physics: NeverScrollableScrollPhysics(),
                                              itemCount: snapshot.data!.docs.length,
                                              itemBuilder: (context, index){
                                                final useridd = snapshot.data!.docs[index]['userid'].toString();
                                                final message = snapshot.data!.docs[index]['message'].toString();

                                                if(userid==useridd){
                                                  print(userid.toString());
                                                  return Column(
                                                    children: [
                                                      SizedBox(height: 10,),
                                                      ClipRRect(
                                                        borderRadius: BorderRadius.circular(15),
                                                        child: InkWell(
                                                          onTap: (){
                                                            messagedetail(context, message);
                                                          },
                                                          child: Container(
                                                            height: height*.13,
                                                            width: width,
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape.rectangle,
                                                                color: Colors.black38
                                                            ),
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Column(
                                                                    children: [
                                                                      Text('New Arrival', style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontWeight: FontWeight.bold,
                                                                        fontSize: 30,
                                                                      ),),
                                                                      Padding(
                                                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                                        child: Text(snapshot.data!.docs[index]['message'].toString(), style: TextStyle(
                                                                            color: Colors.white
                                                                        ),),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Icon(Icons.remove_red_eye,color: Colors.white,)
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                }
                                                else{
                                                  return  Container(

                                                  );
                                                }


                                              });
                                        }
                                      },


                                    ),
                                    SizedBox(height: 10,),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 27.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Daily Expenses',style: TextStyle(
                                              fontSize: 20, fontWeight: FontWeight.w900
                                          ),),
                                          InkWell(
                                            onTap: (){
                                              dailyexpense();
                                            },
                                            child: Container(
                                              child: Text('Add ',),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: Colors.black, // Color of the line
                                                    width: 2.0, // Width of the line
                                                    style: BorderStyle.solid, // Style of the line
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    StreamBuilder(
                                      stream: FirebaseFirestore.instance.collection('dailyexpense').orderBy('time', descending: true)
                                          .snapshots(),

                                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

                                        if(snapshot.connectionState== ConnectionState.waiting){
                                          return Container();

                                        }
                                        else{
                                          return  ListView.builder(
                                              shrinkWrap: true,
                                              physics: NeverScrollableScrollPhysics(),
                                              itemCount: snapshot.data!.docs.length,
                                              itemBuilder: (context, index){
                                                final useridd = snapshot.data!.docs[index]['userid'].toString();
                                                if(userid==useridd)
                                                  return Column(
                                                    children: [
                                                      SizedBox(height: 10,),
                                                      ClipRRect(
                                                        borderRadius: BorderRadius.circular(15),
                                                        child: Container(
                                                          height: height*.15,
                                                          width: width,
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape.rectangle,
                                                              color: Colors.black38
                                                          ),
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [

                                                                Flexible(
                                                                  child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Text('Rs '+snapshot.data!.docs[index]['price'], style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontWeight: FontWeight.bold,
                                                                        fontSize: 30,
                                                                      ),),
                                                                      Align(
                                                                        alignment: Alignment.bottomLeft,
                                                                        child: Text(snapshot.data!.docs[index]['timae'], style: TextStyle(
                                                                          color: Colors.white,
                                                                          //  fontWeight: FontWeight.bold,
                                                                          // fontSize: 30,
                                                                        ),),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),

                                                                Flexible(
                                                                  child: Container(

                                                                    height: 200,
                                                                    child: Text(snapshot.data!.docs[index]['description'], style: TextStyle(
                                                                        color: Colors.white
                                                                    ),),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );

                                              });
                                        }
                                      },


                                    )
                                  ],
                                );
                              }

                            }
                            else{
                              return Container();
                            }


                          });
                    }
                  }
              ),


            ],
          ),
        ),
      )
    )


      ;
  }
  final price = TextEditingController();
  final pricefocus = FocusNode();
  final description = TextEditingController();
  final descriptionfocus = FocusNode();
  Future<void> dailyexpense(){
    final userid = auth.currentUser!.uid;

    return showDialog(context: context,
        builder: (context){
          return Container(
            margin: EdgeInsets.all(20),
            child: AlertDialog(
              title: Center(child: Text('Expences',)),
              content: SingleChildScrollView(
                child: Form(
                  key:  form,
                  child: Column(

                    children: [
                      textfield(
                        mycontroller:price,
                        focusNode: pricefocus,
                        fieldSetter: (value){

                        },
                        keyBoradtype: TextInputType.number,
                        obscureText: false,
                        hint: 'enter price',
                        fieldValidator: (value){
                          return value.isEmpty ? 'enter price': null;


                        },
                        icon: Icon(Icons.monetization_on), label: 'price',),
                      SizedBox(height: 10,),
                      textfield(
                        mycontroller: description,
                        focusNode: descriptionfocus,
                        fieldSetter: (value){

                        },
                        keyBoradtype: TextInputType.text,
                        obscureText: false,
                        hint: 'enter description',
                        fieldValidator: (value){
                          return value.isEmpty ? 'enter description': null;

                        },
                        icon: Icon(Icons.description), label: 'description',)
                    ],
                  ),
                ),
              ),

              actions: [
                Column(
                  children: [

                    Roundbutton(title: 'submit', onpress: (){
                      if(form.currentState!.validate()){
                        final complan = FirebaseFirestore.instance.collection('dailyexpense');
                        final lastmessage = FirebaseFirestore.instance.collection('lastmessage');
                        final time = DateFormat('yyy-MM-dd').format(DateTime.now()).toString();
                        final dateime = DateTime.now().millisecondsSinceEpoch.toString();
                        String id = DateTime.now()
                            .millisecondsSinceEpoch
                            .toString();
                        complan.doc(id).set({

                          'userid':userid.toString(),
                          'date':dateime,
                          'timae':time,
                          'time':dateime,
                          'price':price.text.toString(),
                          'description':description.text.toString(),

                          'view':'view'
                        }).then((value) => {
                          price.clear(),
                          description.clear()
                        });
                        Navigator.pop(context);
                      }




                    })
                    ,
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text('Cancel', style: TextStyle(color:  Colors.red),)),
                  ],
                ),

              ],
            ),
          );
        });
  }
}
