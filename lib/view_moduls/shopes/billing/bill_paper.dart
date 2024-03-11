import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jamal_shap/view_moduls/shopes/dashborad_screen.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:http/http.dart' as http;

import '../products/shope_screen.dart';

class YourFormScreen extends StatefulWidget {
  final int total_price;
  final int total_items;
  final String saleman;
  final shopid;
  final userid;
 // final productid;

  YourFormScreen({required this.total_price, required this.total_items,
    required this.saleman, required this.shopid, required this.userid,
  //  required this.productid
  });

  @override
  _YourFormScreenState createState() => _YourFormScreenState();
}

class _YourFormScreenState extends State<YourFormScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  void deleteCollection(String collectionPath) {
    FirebaseFirestore.instance.collection(collectionPath).get().then((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs) {
        doc.reference.delete();
      }
    });
  }


// Create a PDF document
  final pdf = pw.Document();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text('Buyer Name',style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 23
              ),),
            ),
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
                    validator: (value) {
                      return value!.isEmpty
                          ? 'enter name'
                          : null;
                    },
                    controller: nameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,


                      hintText: 'Enter Buyer Name',

                      //border: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text('Buyer Address',style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 23
              ),),
            ),
            SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Colors.black12,
                  height: 200,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextFormField(
                      validator: (value) {
                        return value!.isEmpty
                            ? 'enter address'
                            : null;
                      },
                      controller: addressController,
                      decoration: InputDecoration(


                          hintText: 'Enter Buyer Address',
                          border: InputBorder.none
                        //border: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () async {

                    if (formKey.currentState!.validate()) {
                      // Form is valid, proceed with form submission
                      submitForm();
                      Future<void> savePdfToFile(pw.Document pdf) async {
                        final pdfBytes = await pdf.save();

                        Printing.layoutPdf(
                          onLayout: (PdfPageFormat format) async => pdfBytes,
                        );
                      }
                      Future<void> generatePdf(PdfPageFormat pageFormat,) async {

                        final pdf = pw.Document();
                        final headers= ['Features', 'Provider', 'Reciver'];
                        // Uint8List imageData = Uint8List.fromList([snapshot.data!.docs[index]['productimage']]);


                        pdf.addPage(
                          pw.Page(
                            build: (pw.Context context) {
                              final date = DateFormat('yyy-MM-dd-KK-mm-ss').format(DateTime.now()).toString();
                              return
                                pw.Column(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  crossAxisAlignment:pw. CrossAxisAlignment.start,
                                  children: [
                                    pw.Center(
                                        child: pw.Text('Product return without bill paper  is not accept',style: pw.TextStyle(fontWeight:pw. FontWeight.bold,
                                  fontSize: 20
                              ))
                                    ),
                                    //

                                    pw.Column(
                                        mainAxisAlignment: pw.MainAxisAlignment.start,
                                        crossAxisAlignment:pw. CrossAxisAlignment.start,
                                        children: [
                                          pw.SizedBox(height: 40),
                                          pw.Text('Buyer Name',style: pw.TextStyle(fontWeight:pw. FontWeight.bold,
                                              fontSize: 30
                              )),
                                          pw.Text(nameController.text, style: pw.TextStyle(
                                              fontSize: 30
                                          ) ),
                                          pw.SizedBox(height: 40),
                                          pw.Text('Buyer Address\n',style: pw.TextStyle(fontWeight:pw. FontWeight.bold,
                                              fontSize: 30
                                          )),
                                          pw.Text( addressController.text , style: pw.TextStyle(
                                              fontSize: 30
                                          )),
                                          pw.SizedBox(height: 40),
                                          pw.Text('Salesman Name', style: pw.TextStyle(fontWeight:pw. FontWeight.bold,
                                              fontSize: 30
                                          )),
                                          pw.Text(widget.saleman, style: pw.TextStyle(
                                              fontSize: 30
                                          )),
                                          pw.SizedBox(height: 40),
                                          pw.Text('Total Items',style: pw.TextStyle(fontWeight:pw. FontWeight.bold,
                                            fontSize: 30
                              )),
                                          pw.Text( widget.total_items.toString(), style: pw.TextStyle(
                                              fontSize: 30
                                          ) ),
                                          pw.SizedBox(height: 40),
                                          pw.Text('Date', style: pw.TextStyle(fontWeight:pw. FontWeight.bold,
                                              fontSize: 30
                                          )),
                                          pw.Text(date, style: pw.TextStyle(
                                              fontSize: 30
                                          )),
                                          pw.SizedBox(height: 40),
                                          pw.Text('Total Price', style: pw.TextStyle(fontWeight:pw. FontWeight.bold,
                                              fontSize: 30
                              )),

                                          pw.Text(widget.total_price.toString(),
                                              style: pw.TextStyle(
                                                  fontSize: 30
                                              )),


                                        ]
                                    ),



                                  ]
                              );
                            },
                          ),
                        );

                        await savePdfToFile(pdf).then((value) => {
                          setState(() {
                            //  _loading = false;
                          })
                        });
                      }
                      final pdf = pw.Document();
                      await generatePdf(PdfPageFormat.a4,);
                    }

                  },

                  child: Container(
                    color: Colors.black,
                    height: 50,
                    width: 250,
                    child: Center(
                      child: Text('Finish',style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          color: Colors.white
                      ),),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void submitForm() async {
    final time  = DateFormat('KK:mm:ss').format(DateTime.now()).toString();
    final date = DateFormat('yyy-MM-dd').format(DateTime.now()).toString();
    final minlisecond = DateTime.now().millisecondsSinceEpoch.toString();

    final generateBill = FirebaseFirestore.instance.collection('bills');

    await generateBill.doc(minlisecond).set({
      'totalbill': widget.total_price.toString(),
      'totalitems': widget.total_items.toString(),
      'buyername': nameController.text,
      'buyeraddres': addressController.text,
      'date': date,
      'shopid':widget.shopid,
      'time':time
    })
        .then((value) {

      CollectionReference upadtedashbord = FirebaseFirestore.instance.collection('allproducts');
      upadtedashbord.doc('products').update({
        'total_sell':FieldValue.increment(widget.total_items),
        'total_items':FieldValue.increment(-widget.total_items)

      });
    })
        .then((value) {

      CollectionReference upadtedashbord = FirebaseFirestore.instance.collection('shopes');
      upadtedashbord.doc(widget.shopid).update({
        'total_sell':FieldValue.increment(widget.total_items),
        'total_product':FieldValue.increment(-widget.total_items)

      })
          .then((value){
        CollectionReference upadtedashbord = FirebaseFirestore.instance.collection('card');
        upadtedashbord.doc(widget.userid).update({
        'bill':0,
          'items':0,

        });

      })
          .then((value){
        final String collection = 'carddiscription'+widget.userid;
        deleteCollection(collection);

      }).then((value) {
        nameController.clear();
        addressController.clear();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>shop()));
      });
    });


    // Navigate back to dashboard screen
    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard()));
  }
}