
import 'package:flutter/material.dart';




class Roundbutton extends StatelessWidget {
  final String title;
  final     VoidCallback onpress;
  final  Color color, textcolor;
  final bool loading;

  const Roundbutton({Key? key,
    required this.title,
    required this.onpress,
    this.textcolor = Colors.white,
    this.color = Colors.black
    ,
    this.loading=false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: InkWell(
        onTap: loading ? null: onpress,
        child:

           Container(

            height: 45,
            decoration: BoxDecoration(

              color: color,
                  borderRadius: BorderRadius.circular(8)
            ),
            child:loading? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Center(child: CircularProgressIndicator(color: Colors.pink,)),
            )
            :Center(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(title,style: Theme.of(context).textTheme.headline2!.
              copyWith(fontSize: 16,color: Colors.white),),
            )),

          ),

      ),
    );
  }
}
