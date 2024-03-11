
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ionicons/ionicons.dart';

import 'cloths_details.dart';
class all_cloths extends StatefulWidget {
  const all_cloths({Key? key}) : super(key: key);

  @override
  State<all_cloths> createState() => _all_clothsState();
}

class _all_clothsState extends State<all_cloths> {
  final auth = FirebaseAuth.instance;
  String serach = "";
  final serachcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final user = auth.currentUser;
    final userid = auth.currentUser!.uid;
    final height = MediaQuery.of(context).size.height*.9;
    final width = MediaQuery.of(context).size.width*.9;
    int cartItemCount =2;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('All Cloths',style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 23
          ),),
        ),

      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,

              children: [
                SizedBox(height: 10,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: Colors.black12,
                      height: 54,
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
                SizedBox(height: 10,),


                SizedBox(height: 10,),


                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:          StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('itemss').snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Text('ERROR');
                      }
                      else{
                        return MasonryGridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          mainAxisSpacing: 1,
                          crossAxisSpacing: 1,
                          gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Number of columns in the grid
// Add horizontal spacing between items

                            //         mainAxisSpacing: 16.0,
                          ),
                          itemCount: snapshot.data!.docs.length, // Total number of items
                          itemBuilder: (BuildContext context, int index) {
                            final brandnamae = snapshot.data!.docs[index]['brandname'].toString();
                            final userd=snapshot.data!.docs[index]['userid'].toString();
                            final shopid=snapshot.data!.docs[index]['shop_id'].toString();
                            final itemid=snapshot.data!.docs[index]['productid'].toString();
                            final itemname=snapshot.data!.docs[index]['prodtuctname'].toString();
                            final quantity=snapshot.data!.docs[index]['productqunatity'].toString();
                            final price=snapshot.data!.docs[index]['product_price'].toString();
                            final productimage=snapshot.data!.docs[index]['productimage3'].toString();
                            final saleman=snapshot.data!.docs[index]['shop_owner'].toString();
                            if(userid==snapshot.data!.docs[index]['userid'].toString()){
                              if(serachcontroller.text.isEmpty){
                                return
                                  Column(

                                    children: [

                                      Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                              onTap: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>cloths_deatils(  barnd_image: productimage,
                                                  brandname: brandnamae,
                                                  userid: userd,
                                                  shopid: shopid,
                                                  itemid: itemid,
                                                  itename: itemname,
                                                  quantity: quantity,
                                                  price: price, saleman: saleman,)));
                                              },
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: Container(
                                                  height: height*.22,
                                                  width: width*.5,
                                                  color: Colors.red,
                                                  child: imagepick(imageurl:
                                                  snapshot.data!.docs[index]['productimage3'],),
                                                ),
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(snapshot.data!.docs[index]['prodtuctname'].toString()),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(snapshot.data!.docs[index]['product_price'].toString())),
                                            )

                                          ],
                                        ),
                                      ),


                                    ],

                                  );
                              }
                              else if(itemname.contains(serachcontroller.text.toLowerCase())){
                                return
                                  Column(

                                    children: [

                                      Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                              onTap: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>cloths_deatils(  barnd_image: productimage,
                                                  brandname: brandnamae,
                                                  userid: userd,
                                                  shopid: shopid,
                                                  itemid: itemid,
                                                  itename: itemname,
                                                  quantity: quantity,
                                                  price: price, saleman: saleman,)));
                                              },
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: Container(
                                                  height: height*.22,
                                                  width: width*.5,
                                                  color: Colors.red,
                                                  child: imagepick(imageurl:
                                                  snapshot.data!.docs[index]['productimage3'],),
                                                ),
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(snapshot.data!.docs[index]['prodtuctname'].toString()),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(snapshot.data!.docs[index]['product_price'].toString())),
                                            )

                                          ],
                                        ),
                                      ),


                                    ],

                                  );
                              }
                              else{
                                return Container();
                              }

                            }
                            else {
                              return Container();
                            }

                          },
                        );
                      }


                    },

                  ),
                ),


              ],
            ),
          ),
        ],
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
          0.4,
      width: MediaQuery.of(context).size.width *
          0.9,
      child: Image(
        fit: BoxFit.fill,
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
}
