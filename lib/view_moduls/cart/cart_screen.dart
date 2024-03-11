


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';


import '../shopes/billing/bill_paper.dart';
import '../shopes/products/all_brand_screen.dart';

class cart extends StatefulWidget {
  final userid;
  const cart({Key? key, required this.userid}) : super(key: key);

  @override
  State<cart> createState() => _cartState();
}

class _cartState extends State<cart> {

  final card = FirebaseFirestore.instance.collection('carddiscription').snapshots();
  final authuserid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    final String collection = 'carddiscription'+widget.userid;
    return Scaffold(
    appBar:  AppBar(
        title: Center(child: Text('Cart',style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 23
        ),)),
      ),

      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection(collection).snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Text('ERROR');
              }
              else{
              return  Expanded(
                child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index){
                      final quantity = snapshot.data!.docs[index]['quantity'];
                      final productid = snapshot.data!.docs[index]['productid'];
                      final price = snapshot.data!.docs[index]['baseprice'];
    final userid = snapshot.data!.docs[index]['userid'];
    final brandname = snapshot.data!.docs[index]['brandname'];
    if(userid==authuserid){
      if(quantity>0){
        return
          Card(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(

                        height: 100,
                        width: 150,
                        child: imagepick(imageurl: snapshot.data!.docs[index]['image'],),
                      ),
                    ),
                    Container(
                      height: 100,
                      child: Column(
                        //itomname
                        children: [
                          Text(snapshot.data!.docs[index]['brandname'],style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 23
                          ),),
                          Text(snapshot.data!.docs[index]['itomname']),
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Text('Rs: '+snapshot.data!.docs[index]['price'].toString()),
                          ),

                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 90,
                        color: Colors.grey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Container(

                              width: 80,
                              child:Center(child: Text(snapshot.data!.docs[index]['quantity'].toString())),
                            ),

                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(

                                color: Colors.black12,
                                width: 80,
                                child: InkWell(
                                    onTap: (){
                                      CollectionReference reduce_quantity = FirebaseFirestore.instance.collection(collection);
                                      reduce_quantity.doc(productid).update({
                                        'quantity':FieldValue.increment(-1),
                                        'price':FieldValue.increment(-price)

                                      }).then((value) {

                                        CollectionReference reduce_item_on_card = FirebaseFirestore.instance.collection('card');
                                        reduce_item_on_card.doc(widget.userid).update({
                                          'bill':FieldValue.increment(-price),
                                          'items':FieldValue.increment(-1),
                                        });
                                        setState(() {

                                        });
                                      }) .then((value) {
                                        CollectionReference updatebrand = FirebaseFirestore.instance.collection('allbrand');
                                        updatebrand.doc(brandname).update({
                                          'total_sell':FieldValue.increment(-1)

                                        });
                                        setState(() {

                                        });

                                      });
                                      setState(() {

                                      });

                                    },
                                    child: Icon(Icons.remove,color:Colors.white,)),
                              ),
                            )

                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
      }
      else{
        return Container();
      }
    }
    else{
      return
      Container();
    }


                  }),
              );
              }
            },

          ),



        
        ],
      ),
bottomNavigationBar: MyBottomWidget(),
    );

  }
}

class MyBottomWidget extends StatefulWidget {
  @override
  State<MyBottomWidget> createState() => _MyBottomWidgetState();
}

class _MyBottomWidgetState extends State<MyBottomWidget> {

  final carditem = FirebaseFirestore.instance.collection('card').snapshots();
  final authuserid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: EdgeInsets.all(16.0),

     child:
     StreamBuilder<QuerySnapshot>(
       stream: carditem,
       builder: (BuildContext context,
           AsyncSnapshot<QuerySnapshot> snapshot) {
         if (snapshot.connectionState == ConnectionState.waiting) {
           return Center(child: CircularProgressIndicator());
         }
         if (snapshot.hasError) {
           return Text('ERROR');
         }
     return  ListView.builder(
         itemCount: snapshot.data!.docs.length,
         itemBuilder: (context, index){
       final userid = snapshot.data!.docs[index]['userid'].toString();
       if(authuserid==userid){
         return  Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 8.0),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(
                     'Total',
                     style: TextStyle(color: Colors.black38,fontSize: 24,fontWeight: FontWeight.w800),
                   ),
                   Text(
                     'Rs: '+ snapshot.data!.docs[index]['bill'].toString(),
                     style: TextStyle(color: Colors.black,fontSize: 20),
                   ),
                 ],
               ),
             ),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 6.0),
               child: ClipRRect(
                 borderRadius: BorderRadius.circular(10),
                 child: InkWell(
                   onTap: (){
                     Navigator.pushReplacement(context,
                         MaterialPageRoute(builder: (context)=>YourFormScreen(
                           total_items: snapshot.data!.docs[index]['items'],
                           total_price: snapshot.data!.docs[index]['bill'],
                           saleman: snapshot.data!.docs[index]['ownername'].toString(),
                           shopid:  snapshot.data!.docs[index]['shopid'],
                           userid: snapshot.data!.docs[index]['userid']
                           // productid: snapshot.data!.docs[index]['productid']
                     )));

                   },
                   child: Container(
                     color: Colors.black,
                     height: 50,
                     width: 200,
                     child: Center(
                       child: Text('Confirm',style: TextStyle(
                           fontWeight: FontWeight.w300,
                           fontSize: 20,
                           color: Colors.white
                       ),),
                     ),
                   ),
                 ),
               ),
             ),
           ],
         );
       }
       else{
         return Container();
       }

       });


     },)

    );
  }
}
