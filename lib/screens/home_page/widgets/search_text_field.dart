import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class SearchTextField extends StatelessWidget {
  final String hintext;

  final Function(String) onSearchingComplete;
  final bool enable;
  String? value;
  SearchTextField(
      {Key? key, required this.hintext, required this.onSearchingComplete,this.enable =true, this.value})
      : super(key: key);
 @override
  Widget build(BuildContext context) {
    return Container(
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Color(0xffEBEBEB),width: 1),
        ),
        child: Center(child: TextFormField(
          onTap: () {

          },
          onFieldSubmitted: onSearchingComplete,
          textInputAction: TextInputAction.search,
          // onSubmitted: (value) {
          //   print("search");
          // },
          cursorColor: Colors.black,
          initialValue: this.value??"",
          enabled: enable,
          style: TextStyle(
            color: Colors.grey,
            fontSize: ScreenUtil().setSp(18),
          ),
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
              bottom: 8,  // HERE THE IMPORTANT PART
            ),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFF6F6F6),
              ),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFF6F6F6),
              ),
            ),
            hintText: hintext,

            hintStyle: TextStyle(
              color: AppColors.text_desc,
              fontSize: ScreenUtil().setSp(14),
              // fontFamily: "Montserrat-Regular",
            ),
            prefixIcon: Transform.scale(
              scale: 0.35,
              child: Image.asset(
                "assets/images/Search.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        ));
  }
}
