import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kappu/components/AppColors.dart';

import '../screens/register/widgets/text_field.dart';

class SaveDialogBox extends StatefulWidget {
  /// Creates a widget combines of  [Container].
  /// [title], [descriptions], [onPressed] must not be null.
  ///
  /// This widget will return dialog to show warning.
  /// For e.g. when user tap on report user icon will show [SaveDialogBox] to warn user about the action.
  const SaveDialogBox({
    Key? key,
    required this.buttonTitle,
    required this.onPressed,
    this.buttonColor = AppColors.red,
  }) : super(key: key);

  final String buttonTitle;
  final Color buttonColor;
  final Function(String) onPressed;


  @override
  _SaveDialogBoxState createState() => _SaveDialogBoxState();
}

class _SaveDialogBoxState extends State<SaveDialogBox> {
  final TextEditingController nameController = TextEditingController();
  late bool isValidName = true;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Stack contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20,),
              Text('Name', style: TextStyle(fontSize: 12, fontFamily: 'Montserrat-Regular', color: AppColors.text_desc),),
              CustomTextFormField(
                controller: nameController,
                validator: (value) =>
                value!.isEmpty ? "Enter Your Name" : null,
                keyboardType: TextInputType.text,
                prefixIcon: const ImageIcon(
                  AssetImage('assets/icons/prf.png'),
                  color: AppColors.app_color,
                ),
                hintText: 'Name',
                isValid: isValidName,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    isValidName = true;
                  } else {
                    isValidName = false;
                  }
                  setState(() {});
                },
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                  onTap: () {
                    widget.onPressed(nameController.text);
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: widget.buttonColor),
                    padding: EdgeInsets.only(
                        left: 25, right: 25, top: 10, bottom: 10),
                    child: Text(
                      'Save',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
