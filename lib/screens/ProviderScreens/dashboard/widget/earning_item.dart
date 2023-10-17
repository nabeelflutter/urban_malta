import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../components/AppColors.dart';

class EarningItem extends StatelessWidget {
  /// Creates a widget combines of [InkWell], [Container], [Expanded].
  ///
  /// At least one of [label], [value], [onClick] must not be null.
  /// This widget used to set header for on boarding screens like [LoginScreen], [ForgotPasswordScreen], [LoginWithNumberScreen].
  ///
  /// This contains [title], [label] and [imagePath]{asset/} to show top header.
  const EarningItem({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.titleColor,
    this.showDivider = true,
  }) : super(key: key);

  final String title;
  final String subTitle;
  final Color titleColor;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: titleColor, fontSize: 16, 
                  // fontFamily: "Montserrat-Bold"
                  ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              subTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.app_black,
                fontSize: 12,
                  // fontFamily: "Montserrat-Medium"
              ),
            ),

            if (showDivider)
              SizedBox(
                height: 15,
              ),
            if (showDivider)
              Divider(
                color: Colors.grey,
                height: 0.5,
              )
          ],
        ));
  }
}
