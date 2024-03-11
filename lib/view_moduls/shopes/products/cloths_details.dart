
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jamal_shap/components/session_controller.dart';
import 'package:jamal_shap/view_moduls/cart/cart_screen.dart';

import '../billing/bill_paper.dart';
class cloths_deatils extends StatefulWidget {
  final barnd_image, userid, brandname, shopid, itename, itemid, quantity, price,saleman;
  const cloths_deatils({Key? key, required this.barnd_image, required this.brandname, required this.userid
  , required this.shopid, required this.itemid, required this.itename, required this.quantity, required this.price, required this.saleman}) : super(key: key);

  @override
  State<cloths_deatils> createState() => _cloths_deatilsState();
}

class _cloths_deatilsState extends State<cloths_deatils> {

  String serach = "";
  final serachcontroller = TextEditingController();




  @override
  Widget build(BuildContext context) {
    final String collection = 'carddiscription'+widget.userid;
    final height = MediaQuery.of(context).size.height*.9;
    final width = MediaQuery.of(context).size.width*.9;
    int cartItemCount =2;
    return Scaffold(


      body: Container(

        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40,),
          
              ClipRRect(
                child: Container(
                  color: Colors.white54,
                  child: Container(
                    decoration: BoxDecoration(
          
                    ),
                    height: 300,
          
          
                    child: Stack(
                      children: [
                        Center(child: ClipRRect(
                            borderRadius:BorderRadius.circular(19),child: Container(
                            width:MediaQuery.of(context).size.width,child: imagepick(imageurl: widget.barnd_image,)))),
          
                        Positioned(child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 13.0),
                          child: InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: CircleAvatar(child: Icon(Icons.arrow_back_ios_rounded))),
                        )),
          
          
          
                      ],
                    ),
                  ),
                ),
              ),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 28.0),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text(widget.itename,style: TextStyle(
             fontWeight: FontWeight.w900,
             fontSize: 23
                 ),),
                 Text('Rs '+ widget.price,style: TextStyle(
             fontWeight: FontWeight.w900,
             fontSize: 23
                 ),),
          
               ],
             ),
           ),
              Padding(
                padding: const EdgeInsets.only(left: 28.0,bottom: 20),
                child: Text(widget.brandname),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Text(
                    'Elevate your style and enjoy luxury with our carefully'
                    ' chosen classic clothes. Feel the highest level of elegance and '
                    'quality in every piece we offer. '
                    'You will feel confident and stylish wherever you go with our clothes',
                textAlign: TextAlign.justify,),
              ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child:   Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Text('Quantity',style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 23
                ),),
                ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            color:  Colors.black12,
            width: 120,
            child:  Center(
              child: Text(widget.quantity,style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 23
              ),),
            ),
          ),
                ),
                CircleAvatar(
          backgroundColor: Colors.grey,
          child: InkWell(
              onTap: (){
          
          
              final DocumentReference userDocRef = FirebaseFirestore.instance.collection('card').doc(widget.userid);
          
              userDocRef.get().then((userDocSnapshot) {
                final value = int.parse(widget.price);
                if (userDocSnapshot.exists) {
                  // Field exists, update its value
                  userDocRef.update({
                    'items': FieldValue.increment(1),
                    'bill':FieldValue.increment(value),
                    'shopid':widget.shopid,
                    'userid':widget.userid,
                  });
                } else {
                  // Field doesn't exist, add it to the document with an initial value
                  userDocRef.set({
                    'items': 1,
                    'bill':value,
                    'userid':widget.userid,
                    'ownername':widget.saleman,
                    'shopid':widget.shopid.toString()
                  });
                }
              }).then((value) {
                final value = int.parse(widget.price);
                final String collection = 'carddiscription'+widget.userid;
                final DocumentReference   carddeatil = FirebaseFirestore.instance.collection(collection).doc(widget.itemid);
               carddeatil.get().then((itemid) {
                 if(itemid.exists){
                   carddeatil.update({
                     'price':FieldValue.increment(value),
                     'quantity':FieldValue.increment(1),
                   });
          
                 }
                 else{
                   carddeatil.set({
                     'itomname':widget.itename,
                     'brandname':widget.brandname,
                     'price':value,
                     'baseprice':value,
                     'image':widget.barnd_image,
                     'barndname':widget.brandname,
                     'quantity':1,
                     'productid':widget.itemid,
                     'userid':widget.userid,
          
                   });
                 }
               })
                   .then((value) {
                 CollectionReference updatebrand = FirebaseFirestore.instance.collection('allbrand');
                 updatebrand.doc(widget.brandname).update({
                   'total_sell':FieldValue.increment(1)

                 });

               });
          
          
              });
              },
              child: Icon(Icons.add)),
                ),

              ],
            ),
          ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0,left: 25,right: 25,bottom: 20),
                child:   Container(

                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StreamBuilder<QuerySnapshot>(
                      stream:  FirebaseFirestore.instance.collection(collection).snapshots(),
                      builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Text('ERROR');
                        }
                        else {
                       return   Expanded(
                         child: ListView.builder(
                           shrinkWrap: true,
                             physics: NeverScrollableScrollPhysics(),
                             itemCount: snapshot.data!.docs.length,
                             itemBuilder: (context, index){

                              final productid = snapshot.data!.docs[index]['productid'];

                              final itemcount = snapshot.data!.docs[index]['quantity'];
                              if(widget.itemid==productid){
                  if(itemcount>0){
                    return  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        InkWell(
                          onTap: (){
                            final price = int.parse(widget.price);
                            CollectionReference reduce_item_on_card = FirebaseFirestore.instance.collection('card');
                            reduce_item_on_card.doc(widget.userid).update({
                              'bill':FieldValue.increment(-price),
                              'items':FieldValue.increment(-1),
                              'userid':widget.userid,
                            }).then((value) {
                              final value = int.parse(widget.price);
                              CollectionReference reduce_item_on_card = FirebaseFirestore.instance.collection(collection);
                              reduce_item_on_card.doc(widget.itemid).update({
                                'price':FieldValue.increment(-value),
                                'quantity':FieldValue.increment(-1),

                              });

                            }). then((value) {
                            CollectionReference updatebrand = FirebaseFirestore.instance.collection('allbrand');
                            updatebrand.doc(widget.brandname).update({
                            'total_sell':FieldValue.increment(-1)

                            });

                            });
                            setState(() {

                            });

                          },
                          child:    Icon(Icons.cancel, size: 74,
                              color: Colors.grey

                          ),

                        ),
                        Text('Cancel', style: TextStyle(
                            fontSize: 20
                        ),)
                      ],
                    );
                  }
                  else{
                    return  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.cancel, size: 74,
                            color: Colors.grey

                        ), Text('Cancel', style: TextStyle(
                            fontSize: 20
                        ),)

                      ],
                    );
                  }

                              }
                              else{
                                return Container();
                              }

                            }),
                       );

                        }
                      }
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 23),


                        child: Column(

                          children: [
                            SizedBox(height: 12,),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>cart(userid: widget.userid,)));
                              },
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.grey,
                                child:

                                StreamBuilder<DocumentSnapshot>(
                                    stream: FirebaseFirestore.instance.collection('card').
                                    doc(widget.userid).snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return Container(); // Loading state
                                      }

                                      int badgeCount = snapshot.data?['items'] ?? 0;
                                      if(badgeCount > 0){
                                        FlutterAppBadger.updateBadgeCount(badgeCount);
                                      }




                                      print(badgeCount);

                                      return Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 10.0),
                                            child: Icon(Icons.shopping_cart, size: 50,
                                                color: Colors.white

                                            ),
                                          ),

                                          if (badgeCount > 0)
                                            buildBadge(badgeCount.toString()),


                                        ],

                                      );

                                    }
                                ),
                               // Icon(Icons.shopping_cart,size: 40,),
                              ),
                            ),
                            SizedBox(height: 4,),
                            Text('Cart', style: TextStyle(
                              fontSize: 20
                            ),)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
             Container()
            ],
          ),
        ),
      ),

      // AppBar(
      //   title: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Text('Dashborad',style: TextStyle(
      //         fontWeight: FontWeight.w900,
      //         fontSize: 23
      //     ),),
      //   ),
      //
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.all(24.0),
      //       child: Row(
      //         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Icon(Ionicons.alert,size: 10,
      //             color: Colors.black,),
      //
      //
      //           Icon(Icons.shopping_cart, size: 20,),
      //
      //         ],
      //       ),
      //     )
      //   ],
      // )
    );
  }

}
Widget buildBadge(String badgeText) {
  return Positioned(
    top: 1,
    bottom: 0,
    right: 0,

    child: Container(
      padding: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(100),
      ),
      constraints: BoxConstraints(
        minWidth: 16,
        minHeight: 16,
      ),


        child: Text(
          badgeText,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      ),

  );
}
class imagepick extends StatelessWidget {

  final imageurl;

  const imagepick({Key? key,
    required this.imageurl,

  }) : super(key: key,

  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
      MediaQuery.of(context).size.height *
          0.5,

      child: Image(
        fit: BoxFit.fitWidth,
        image: NetworkImage(imageurl),
        loadingBuilder: ( BuildContext context, Widget child, ImageChunkEvent? loading ){

          if(loading==null)
            return child;
          return Container(
            height:
            MediaQuery.of(context).size.height *
                0.4,
            width: MediaQuery.of(context).size.width *
                0.9,
            decoration: BoxDecoration(
                color: Colors.green.shade200
            ),
            child: Center(


                child: CircularProgressIndicator(color: Colors.black,)),
          );
        },
        errorBuilder: (contex, exception, stack){
          return Container(
            decoration: BoxDecoration(
                color: Colors.green.shade200
            ),

            height:
            MediaQuery.of(context).size.height *
                0.3,
            width: MediaQuery.of(context).size.width *
                0.9,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [

                  Icon(Icons.wifi_off, color: Colors.black,
                    size: 30,),
                  Container(
                      margin: EdgeInsets.only(bottom: 13),
                      child: Text('check internet connection!'))
                ],
              ),
            ),
          );
        },

      ),
    );
  }
  Widget buildBadge(String badgeText) {
    return Positioned(
      top: 0,
      right: 0,

      child: Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(8),
        ),
        constraints: BoxConstraints(
          minWidth: 16,
          minHeight: 16,
        ),
        child: Text(
          badgeText,
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
