

//dashbord screen
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jamal_shap/components/session_controller.dart';
class all_messages extends StatefulWidget {
  const all_messages({Key? key}) : super(key: key);

  @override
  State<all_messages> createState() => _all_messagesState();
}

class _all_messagesState extends State<all_messages> {
  String serach = "";
  final serachcontroller = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final user = auth.currentUser;
    final userid = auth.currentUser!.uid;
    final height = MediaQuery.of(context).size.height*.9;
    final width = MediaQuery.of(context).size.width*.9;
    int cartItemCount =0;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text('All Messages',style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 23
            ),),
          ),
          actions: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                IconButton(
                  icon: Icon(Icons.email),
                  onPressed: () {
                    // Add your cart button logic here
                  },
                ),
                if (cartItemCount > 0)
                  Positioned(
                    left: 1,
                    top: 5,
                    child: Container(


                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '$cartItemCount',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),


      ),
      body: SingleChildScrollView(
        child: Column(
          children: [


            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Colors.black12,
                  height: 50,
                  width: double.infinity,
                  child: TextFormField(
                    onChanged: (String value) {
                      setState(() {});
                      serach = value;
                    },
                    controller: serachcontroller,
                    decoration: InputDecoration(

                      suffixIcon: Icon(Icons.search_rounded),
                      hintText: 'Serach Here',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      //border: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20,),

            SizedBox(height: 10,),

            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('adminmessage').snapshots(),

              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

                if(snapshot.connectionState== ConnectionState.waiting){
                  return Container();

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
                                    messagedetail(context , message);
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


            )
          ],
        ),
      ),
    );
  }
}
messagedetail(BuildContext context, final phone){

  return showDialog(context: context,
      builder: (context){
        return Container(
          width:  MediaQuery.of(context).size.width*.9,
          margin: EdgeInsets.all(20),
          child: AlertDialog(
            title: Center(child: Text('New Arrival ', style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),)),
            content: SingleChildScrollView(
              child: Column(

                children: [
                  Container(
                    height: 250,
                    width:  MediaQuery.of(context).size.width*.9,
                    child: Text(phone),
                  )


                ],
              ),
            ),

            actions: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    height: 50,
                    width: 100,
                    color: Colors.black,
                    child: Center(
                      child: InkWell(

                          onTap: (){
                        Navigator.pop(context);
                      }, child:
                      Text('Okay', style: TextStyle(color: Colors.white, fontSize: 20),)),
                    ),
                  ),
                ),
              ),

            ],
          ),
        );
      });
}
