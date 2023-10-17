

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'AppColors.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;

  MyAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
              title,
              style: TextStyle(fontSize: 20.sp, color: Colors.black, )),
        ],
      ),
      backgroundColor: Colors.white,
      leading: Padding(
        padding: EdgeInsets.all(10),
        child:
        RawMaterialButton(
          onPressed: () => Navigator.of(context).pop(),
          fillColor: AppColors.app_color,
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 20.0,
            color: Colors.white,
          ), shape: CircleBorder(),
        ),
      ),
      shadowColor: Colors.black.withOpacity(0.14),
      elevation: 1,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}