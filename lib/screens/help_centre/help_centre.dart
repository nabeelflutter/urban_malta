import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/screens/help_centre/widgets/alert_dialogue.dart';

class HelpCentre extends StatefulWidget {
  const HelpCentre({Key? key}) : super(key: key);

  @override
  _HelpCentreState createState() => _HelpCentreState();
}

class _HelpCentreState extends State<HelpCentre> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // askquestion.png
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(18)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(35)),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.app_color,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
                child: Image.asset(
                  "assets/images/askquestion.png",
                  height: ScreenUtil().setHeight(250),
                ),
              ),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(50),
          ),
          Text(
            'Hello Huzaifa! How we can help?',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: ScreenUtil().setSp(18)),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(30),
          ),
          Text(
            'Ask a Question?',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: ScreenUtil().setSp(14)),
          ),
          const TextField(
            keyboardType: TextInputType.multiline,
            minLines: 1, //Normal textInputField will be displayed
            maxLines: 5, // when user presses enter it will adapt to it
          ),
          SizedBox(
            height: ScreenUtil().setHeight(60),
          ),
          GestureDetector(
            onTap: () {
              showaskedDialog(context);
            },
            child: Container(
              height: ScreenUtil().setHeight(40),
              width: double.infinity,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: AppColors.app_color
                  // gradient: LinearGradient(
                  //   colors: [
                  //     Color.fromARGB(255, 50, 125, 196),
                  //     Color.fromARGB(255, 23, 105, 212)
                  //   ],
                  //   begin: Alignment(-1.0, -4.0),
                  //   end: Alignment(1.0, 4.0),
                  // )
                  ),
              child: Center(
                child: Text(
                  'Ask',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: ScreenUtil().setWidth(16),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
