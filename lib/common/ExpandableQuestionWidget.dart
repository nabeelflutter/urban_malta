import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/components/AppColors.dart';

class ExpandableQuestionWidget extends StatefulWidget {
  final String? answer;
  final String? question;

  const ExpandableQuestionWidget({Key? key, this.answer, this.question})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ExpandableQuestionWidgetState();
  }
}

class ExpandableQuestionWidgetState extends State<ExpandableQuestionWidget> {
  bool showanser = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: Column(
        children: [
          Container(
            color: showanser ? Color(0xff4995EB).withOpacity(0.2) : Colors.white,
            child: Row(
              children: [
                // Container(width: 5, height: 30, color: Colors.black),
                10.horizontalSpace,
                Text(
                  widget.question!,
                  style: TextStyle(
                      color: showanser ? AppColors.color_161616 : AppColors.text_desc,
                      fontSize: 12),
                ),
                Spacer(),
                IconButton(
                    onPressed: () {
                      setState(() {
                        showanser = !showanser;
                      });
                    },
                    icon: Icon(
                      showanser ? Icons.close : Icons.add,
                      size: 20,
                      color:
                          showanser ? AppColors.app_color : AppColors.text_desc,
                    )),
              ],
            ),
          ),
          // if (showanser)
          //   const SizedBox(
          //     height: 10,
          //   ),
          if (showanser)
            Container(
                color: Color(0xff4995EB).withOpacity(0.2),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Text(widget.answer!,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: AppColors.app_black,
                         
                          fontSize: 12)),
                ),)
        ],
      ),
    );
  }
}
