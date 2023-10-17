import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../components/AppColors.dart';

Widget HomeItem({
  String? title,
  String? imagePath,
  Function()? onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 190,
      width: 160,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
        
          blurRadius: 5,
          offset: Offset(0, 3), 
        ),
      ], borderRadius: BorderRadius.circular(20), color: Color(0xffF1F6FB)),
      child: Column(
        children: [
          Image.asset(
            imagePath!,
            height: 160,
          ),
          Text(
            title!,
            style: TextStyle(
                fontWeight: FontWeight.w500, color: Color(0xff7F8E9D)),
          )
        ],
      ),
    ),

    // Card(
    //   elevation: 2,
    //   color: Colors.white,
    //   child: Padding(
    //     padding: const EdgeInsets.all(10),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children:  [
    //         Image.asset(imagePath!,
    //             height: 80,
    //             width: 80,
    //             fit: BoxFit.cover),

    //         SizedBox(
    //           height: 10,
    //         ),
    //         Text(
    //           title!,
    //           textAlign: TextAlign.center,
    //           style: TextStyle(
    //               color: AppColors.text_desc,
    //               fontSize: 12,
    //               fontFamily: "Montserrat-Medium"
    //           ),
    //         )
    //       ],
    //     ),
    //   ),

    // ),
  );
}