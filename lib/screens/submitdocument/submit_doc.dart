import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kappu/common/dialogues.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/screens/gig/AddGig.dart';
import 'package:kappu/screens/submitdocument/add_photo.dart';

import '../../common/CircleButton.dart';

class AddDocument extends StatefulWidget {
  final Map<String, dynamic> bodyprovider;
  const AddDocument({Key? key, required this.bodyprovider}) : super(key: key);

  @override
  State<AddDocument> createState() => _AddDocumentState();
}

class _AddDocumentState extends State<AddDocument> {
  bool isUploading = false;
  double progress = 0;
  File? doc;
  File? licence;

  Future getImage(ImageSource imageSource, context, int type) async {
    XFile? image;

    image = await ImagePicker().pickImage(source: imageSource);
    ImageCropper imageCropper = ImageCropper();
    if (image != null ) {
      File? croppedFile = await imageCropper.cropImage(
          sourcePath: image.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2
          ],
          androidUiSettings: const AndroidUiSettings(
              toolbarTitle: 'Crop',
              toolbarColor: Colors.blue,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true),
          iosUiSettings: const IOSUiSettings(
            minimumAspectRatio: 1,
          ));
      if (croppedFile != null) {
        setState(() {
          if(type==1){
            doc = croppedFile;
          }else{
            licence = croppedFile;
          }
        });

        // await uploadFile(await compressimage(croppedFile));
      }
    }
    Navigator.pop(context);
  }

  Future source(BuildContext context, int type) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
              title: const Text("Choose Option"),
              content: const Text(
                'Select Source',
              ),
              insetAnimationCurve: Curves.decelerate,
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Icon(
                          Icons.photo_camera,
                          size: 28,
                        ),
                        Text(
                          "Camera",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              decoration: TextDecoration.none),
                        ),
                      ],
                    ),
                    onTap: () {
                      //   Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (context) {
                            Navigator.pop(context);
                            getImage(ImageSource.camera, context, type);
                            return const Center(
                                child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ));
                          });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Icon(
                          Icons.photo_library,
                          size: 28,
                        ),
                        Text(
                          "Gallery",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              decoration: TextDecoration.none),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            getImage(ImageSource.gallery, context, type);
                            return const Center(
                                child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ));
                          });
                    },
                  ),
                ),
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(15, 30, 15, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: ScreenUtil().setHeight(40)),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          "assets/images/first-screen-logo.png",
                          height: 80.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(10)),

                    Row(
                      children: [
                        Text(
                          "Add Profile GIG",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: AppColors.color_green,
                              fontSize: ScreenUtil().setSp(18),
                              fontWeight: FontWeight.w500),
                        ),
                        5.horizontalSpace,
                        CircleButton(size:20, iconData: Icons.arrow_forward_ios,iconColor:Colors.white, color: AppColors.color_green,),
                      ],
                    ),
                    15.verticalSpace,
                    Text(
                      "Submit Document (Residence Permit Card | Maltese ID Card)",
                      style: TextStyle(
                          color: AppColors.text_desc,
                          fontSize: ScreenUtil().setSp(14),
                          fontWeight: FontWeight.w500),
                    ),
                    10.verticalSpace,
                    AddPhotoWidget(
                      isUploading: isUploading,
                      onTap: () {
                        source(context, 1);
                      },
                      filePath:doc,
                      icon: Icons.upload,
                      progress: progress,
                      isImage: false,
                      onTapCancel: () {
                        setState(() {
                          // uploadTask.cancel();
                          isUploading = false;
                        });
                      },
                    ),
                    15.verticalSpace,
                    Row(
                      children: [
                        Checkbox(value: true, onChanged: (b){}, ),
                        Text("For licenced work", style: TextStyle(
                            color: Colors.black,
                            fontSize: ScreenUtil().setSp(14),
                            fontWeight: FontWeight.w500),)
                      ],
                    ),

                    10.verticalSpace,
                    Text(
                      "Kindly provide additional documents for licensed work. (Driver, AC installer, Food handling certificate for caterers.",
                      style: TextStyle(
                          color: AppColors.text_desc,
                          fontSize: ScreenUtil().setSp(14),),
                    ),
                    10.verticalSpace,
                    AddPhotoWidget(
                      isUploading: isUploading,
                      filePath: licence,
                      onTap: () {
                        source(context, 2);
                      },
                      icon: Icons.upload,
                      progress: progress,
                      isImage: false,
                      onTapCancel: () {
                        setState(() {
                          // uploadTask.cancel();
                          isUploading = false;
                        });
                      },
                    ),
                    5.verticalSpace,
                    Text(
                      "If you are providing any service where additional documents are required we will revert back to you.",
                      style: TextStyle(
                          color: AppColors.red,
                          fontSize: ScreenUtil().setSp(14)),
                    ),
                    20.verticalSpace,
                    SizedBox(
                      height: ScreenUtil().screenHeight * 0.07,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    ScreenUtil().screenHeight * 0.035)),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Opacity(
                              opacity: 0,
                              child: Icon(Icons.arrow_forward_ios),
                            ),
                            Text(
                              "Submit",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 14.sp,
                                // fontFamily: 'Montserrat-Medium',
                              ),
                            ),
                            Image.asset('assets/icons/arw.png', scale: 1.0),
                          ],
                        ),
                        onPressed: () {
                          if(doc!=null && licence!=null){
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => AddGig(bodyprovider: widget.bodyprovider, doc: doc!, licence: licence!)));
                          }else{
                            showAlertDialog(
                                error: "Please add documents",
                                errorType: "Alert");
                          }
                        },
                      ),
                    ),

                  ],
                )),

          ],
        ),
      ),
    );
    // return Column(
    //   children: [
    //     AddPhotoWidget(
    //       isUploading: isUploading,
    //       onTap: () {
    //         source(context, false);
    //       },
    //       progress: progress,
    //       isImage: false,
    //       onTapCancel: () {
    //         setState(() {
    //           // uploadTask.cancel();
    //           isUploading = false;
    //         });
    //       },
    //     ),
    //   ],
    // );
  }

  void doRegister() async{

  }
}