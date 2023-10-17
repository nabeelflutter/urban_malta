import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../components/AppColors.dart';

class CustomToggleButton extends StatelessWidget {
  /// Creates a widget combines of [InkWell], [Container], [Expanded].
  ///
  /// At least one of [label], [value], [onClick] must not be null.
  /// This widget used to set header for on boarding screens like [LoginScreen], [ForgotPasswordScreen], [LoginWithNumberScreen].
  ///
  /// This contains [title], [label] and [imagePath]{asset/} to show top header.
  const CustomToggleButton({
    Key? key,
    required this.isSelected,
    required this.onChange,
  }) : super(key: key);

  final bool isSelected;
  final Function(bool) onChange;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChange(false),
        child:Container(
      width: 50,
      height: 25,
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: AppColors.app_color, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          if (!isSelected)
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
            ),
          Spacer(),
          if (isSelected)
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
            )
        ],
      ),
    ));
  }
}
