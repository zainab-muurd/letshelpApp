import 'package:flutter/material.dart';

import '../theme/colors.dart';
class HomeScreenWidget extends StatelessWidget {
  const HomeScreenWidget({Key? key,required this.icon , required this.text ,this.onTpa}) : super(key: key);
    final String text ;
    final IconData icon ;
    final Function()? onTpa;
   @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),

      child: Material(
         shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
        color: kTeal400,
        elevation: 15,
        shadowColor: kTeal400,

        child: InkWell(
          onTap: onTpa,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon,color: Colors.white,size: 77,),
                Text(text,style: TextStyle(color:Colors.white),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
