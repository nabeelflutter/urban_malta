import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kappu/common/dialogues.dart';
import 'package:kappu/common/validation_dialogbox.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/constants/storage_manager.dart';
import 'package:kappu/models/serializable_model/GigListResponse.dart';
import 'package:kappu/net/base_dio.dart';
import 'package:kappu/screens/gig/gig_animation.dart';
import 'package:kappu/screens/submitdocument/add_photo.dart';
import 'package:path_provider/path_provider.dart';

import '../../common/bottom_nav_bar.dart';
import '../../net/http_client.dart';
import 'Create_first_gig.dart';

class AddGig extends StatefulWidget {
  final Map<String, dynamic> bodyprovider;
  bool? isFromAddGig = false;
  final PageController pageController;
  final InputData inputData;

  // final File doc;
  // final File licence;
  bool? isFromEditGig = false;
  GigListResponse? myGig;

  AddGig(
      {Key? key,
      required this.bodyprovider,
      this.isFromAddGig,
      this.isFromEditGig,
      this.myGig,
      required this.inputData,
      required this.pageController})
      : super(key: key);

  @override
  State<AddGig> createState() => _AddGigState();
}

class _AddGigState extends State<AddGig> {
//  void _onDataCollected(List<String> data) {
//     widget.inputData.skills = data;

//     // You can perform other operations with the data if needed
//     // ...

//     // Move to the next page
//     widget.pageController.nextPage(
//       duration: Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }

  bool isUploading = false;
  bool isLoading = false;
  double progress = 0;
  List<File> images = [];

  @override
  void initState() {
    super.initState();
    if (widget.isFromEditGig ?? false) {
      setState(() {
        isLoading = true;
      });
      for (var i = 0;
          i < widget.myGig!.servicepackages!.gigdocument!.length;
          i++) {
        getFileFromUrl(widget.myGig!.servicepackages!.gigdocument![i]);
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  Future getImage(ImageSource imageSource, context, bool isVideo) async {
    XFile? image;
    image = await ImagePicker().pickImage(source: imageSource);
    ImageCropper imageCropper = ImageCropper();
    print(image);
    print(imageCropper);
    print(isVideo);
    if (image != null && !isVideo) {
      File? croppedFile = await imageCropper.cropImage(
          sourcePath: image.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2
          ],
          androidUiSettings: const AndroidUiSettings(
              toolbarTitle: 'Crop',
              toolbarColor: AppColors.app_color,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true),
          iosUiSettings: const IOSUiSettings(
            minimumAspectRatio: 1,
          ));
      print(croppedFile);
      if (croppedFile != null) {
        setState(() {
          images.add(croppedFile);
        });
      }
    }
    Navigator.pop(context);
  }

  // Future source(BuildContext mContext, bool isVideo) async {
  //   return showDialog(
  //       context: mContext,
  //       builder: (BuildContext context) {
  //         return CupertinoAlertDialog(
  //             title: const Text("Choose Option"),
  //             content: const Text(
  //               'Select Source',
  //             ),
  //             insetAnimationCurve: Curves.decelerate,
  //             actions: <Widget>[
  //               Padding(
  //                 padding: const EdgeInsets.all(20.0),
  //                 child: GestureDetector(
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: const <Widget>[
  //                       Icon(
  //                         Icons.photo_camera,
  //                         size: 28,
  //                       ),
  //                       Text(
  //                         "Camera",
  //                         style: TextStyle(
  //                             fontSize: 15,
  //                             color: Colors.black,
  //                             decoration: TextDecoration.none),
  //                       ),
  //                     ],
  //                   ),
  //                   onTap: () {
  //                     //   Navigator.pop(context);
  //                     showDialog(
  //                         context: context,
  //                         builder: (context) {
  //                           getImage(ImageSource.camera, context, isVideo);
  //                           return const Center(
  //                               child: CircularProgressIndicator(
  //                             strokeWidth: 2,
  //                             valueColor:
  //                                 AlwaysStoppedAnimation<Color>(Colors.white),
  //                           ));
  //                         });
  //                   },
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.all(20.0),
  //                 child: GestureDetector(
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: const <Widget>[
  //                       Icon(
  //                         Icons.photo_library,
  //                         size: 28,
  //                       ),
  //                       Text(
  //                         "Gallery",
  //                         style: TextStyle(
  //                             fontSize: 15,
  //                             color: Colors.black,
  //                             decoration: TextDecoration.none),
  //                       ),
  //                     ],
  //                   ),
  //                   onTap: () {
  //                     Navigator.pop(context);
  //                     showDialog(
  //                         barrierDismissible: false,
  //                         context: context,
  //                         builder: (context) {
  //                           getImage(ImageSource.gallery, context, isVideo);
  //                           return const Center(
  //                               child: CircularProgressIndicator(
  //                             strokeWidth: 2,
  //                             valueColor:
  //                                 AlwaysStoppedAnimation<Color>(Colors.white),
  //                           ));
  //                         });
  //                   },
  //                 ),
  //               ),
  //             ]);
  //       });
  // }

  Future source(BuildContext mContext, bool isVideo) async {
    return showModalBottomSheet(
      context: mContext,
      backgroundColor: Colors.transparent, // Set background to transparent
      builder: (BuildContext context) {
        return ClipRRect(
          // Apply rounded corners to the bottom sheet
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(22),
            topRight: Radius.circular(22),
          ),
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(Icons.photo_camera, size: 28),
                    title: const Text(
                      "Camera",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera, context, isVideo);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(Icons.photo_library, size: 28),
                    title: const Text(
                      "Gallery",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery, context, isVideo);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          // title: const Text(
          //   "Add GIG Profile",
          //   style: TextStyle(
          //     fontSize: 22,
          //     fontWeight: FontWeight.w600,
          //     color: Colors.black,
          //   ),
          leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back_ios_new,color: AppColors.iconColor,))
        ),
        body: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Upload pictures for\nyour GiG',
                style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              const Text(
                "Showcase your skills with photos! This\nhelps instill trust and gives clients a peek\ninto your work quality. check out the\nexamples below. ",
                style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey,
                    letterSpacing: 0.5),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            // border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.asset(
                          'assets/images/add_gig_1.png',
                          fit: BoxFit.cover,
                        ),
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            // border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.asset(
                          'assets/images/add_gig_2.png',
                          fit: BoxFit.cover,
                        ),
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            // border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.asset(
                          'assets/images/add_gig_3.png',
                          fit: BoxFit.cover,
                        ),
                      ))
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Text(
                "Upload Multiple Images",
                style: TextStyle(
                  fontFamily: 'Raleway',
                  color: AppColors.text_desc,
                  fontSize: ScreenUtil().setSp(14),
                  // fontFamily: 'Montserrat-Medium'
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              AddPhotoWidget(
                isUploading: false,
                onTap: () async {
                  if (images.length >= 3) {
                    await showMaxImageSelectionAlert(context);
                  } else {
                    await source(context, false);
                  }
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
              20.verticalSpace,
              images != null && images.length > 0
                  ? Container(
                      height: 100,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: images.length,
                          itemBuilder: (_, index) {
                            return Container(
                                margin: EdgeInsets.only(left: 5),
                                width: 100,
                                height: 100,
                                child: AddPhotoWidget(
                                  isUploading: isUploading,
                                  filePath: images[index],
                                  // onTap: () {
                                  //   source(context, false);
                                  // },
                                  onTap: () async {
                                    if (images.length >= 3) {
                                      await showMaxImageSelectionAlert(context);
                                    } else {
                                      await source(context, false);
                                    }
                                  },

                                  icon: Icons.upload,
                                  progress: progress,
                                  isImage: false,
                                  onTapCancel: () {
                                    print('aaaa');
                                    setState(() {
                                      images.removeAt(index);
                                    });
                                  },
                                ));
                          }),
                    )
                  : SizedBox(),
              Spacer(),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    onPressed: () {
                      print('ajay Rajput${doRegister}');
                      doRegister();
                    },
                    child: Text('Submit')),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
                // height: 15,
              ),
            ],
          ),
        )
        //  SingleChildScrollView(
        //     child: Stack(
        //   children: [
        //     Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Padding(
        //             padding: const EdgeInsets.fromLTRB(15, 30, 15, 15),
        //             child: Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 SizedBox(height: ScreenUtil().setHeight(40)),
        //                 // Center(
        //                 //   child: Image.asset(
        //                 //     "assets/icons/logo-no_shadow.png",
        //                 //     height: 80.h,
        //                 //     fit: BoxFit.cover,
        //                 //   ),
        //                 // ),
        //                 // SizedBox(height: ScreenUtil().setHeight(10)),
        //                 // Center(
        //                 //   child: Text(
        //                 //     "Add GIG Profile",
        //                 //     style: TextStyle(
        //                 //         color: Colors.black,
        //                 //         fontSize: ScreenUtil().setSp(24),
        //                 //         fontFamily: "Montserrat-Bold"),
        //                 //   ),
        //                 // ),
        //                 // 15.verticalSpace,
        //                 Text(
        //                   "Upload Multiple Images",
        //                   style: TextStyle(
        //                       color: AppColors.text_desc,
        //                       fontSize: ScreenUtil().setSp(14),
        //                       fontFamily: 'Montserrat-Medium'),
        //                 ),
        //                 10.verticalSpace,
        //                 AddPhotoWidget(
        //                   isUploading: false,
        //                   // onTap: () async {
        //                   //   await source(context, false);
        //                   // },
        //                   onTap: () async {
        //                     if (images.length >= 3) {
        //                       await showMaxImageSelectionAlert(context);
        //                     } else {
        //                       await source(context, false);
        //                     }
        //                   },

        //                   icon: Icons.upload,
        //                   progress: progress,
        //                   isImage: false,
        //                   onTapCancel: () {
        //                     setState(() {
        //                       // uploadTask.cancel();
        //                       isUploading = false;
        //                     });
        //                   },
        //                 ),
        //                 20.verticalSpace,
        //                 images != null && images.length > 0
        //                     ? Container(
        //                         height: 100,
        //                         child: ListView.builder(
        //                             shrinkWrap: true,
        //                             scrollDirection: Axis.horizontal,
        //                             itemCount: images.length,
        //                             itemBuilder: (_, index) {
        //                               return Container(
        //                                   margin: EdgeInsets.only(left: 5),
        //                                   width: 100,
        //                                   height: 100,
        //                                   child: AddPhotoWidget(
        //                                     isUploading: isUploading,
        //                                     filePath: images[index],
        //                                     // onTap: () {
        //                                     //   source(context, false);
        //                                     // },
        //                                     onTap: () async {
        //                                       if (images.length >= 3) {
        //                                         await showMaxImageSelectionAlert(
        //                                             context);
        //                                       } else {
        //                                         await source(context, false);
        //                                       }
        //                                     },

        //                                     icon: Icons.upload,
        //                                     progress: progress,
        //                                     isImage: false,
        //                                     onTapCancel: () {
        //                                       print('aaaa');
        //                                       setState(() {
        //                                         images.removeAt(index);
        //                                       });
        //                                     },
        //                                   ));
        //                             }),
        //                       )
        //                     : SizedBox(),
        //                 20.verticalSpace,
        //                 SizedBox(
        //                   height: ScreenUtil().screenHeight * 0.07,
        //                   child: TextButton(
        //                     style: ButtonStyle(
        //                       backgroundColor:
        //                           MaterialStateProperty.all(AppColors.app_color),
        //                       shape: MaterialStateProperty.all(
        //                         RoundedRectangleBorder(
        //                             borderRadius: BorderRadius.circular(
        //                                 ScreenUtil().screenHeight * 0.035)),
        //                       ),
        //                     ),
        //                     child: Row(
        //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                       children: [
        //                         const Opacity(
        //                           opacity: 0,
        //                           child: Icon(Icons.arrow_forward_ios),
        //                         ),
        //                         Text(
        //                           "Submit",
        //                           style: TextStyle(
        //                             fontWeight: FontWeight.w500,
        //                             color: Colors.white,
        //                             fontSize: 14.sp,
        //                             fontFamily: 'Montserrat-Medium',
        //                           ),
        //                         ),
        //                         Image.asset('assets/icons/arw.png', scale: 1.0),
        //                       ],
        //                     ),
        //                     onPressed: () {
        //                       doRegister();
        //                     },
        //                   ),
        //                 ),
        //               ],
        //             )),
        //       ],
        //     ),
        //     if (isLoading) CustomProgressBar()
        //   ],
        // )),

        );
  }

  void doRegister() async {
    print(widget.isFromAddGig);
    if (images.isEmpty) {
      showAlertDialog(error: "Please add gig image", errorType: "Alert");
    } else {
      setState(() {
        isLoading = true;
      });
      if (widget.isFromAddGig ?? false) {
        await HttpClient().addGig({
          'category': widget.inputData.categoryId,
          "description": widget.inputData.desc,
          "Perhour": widget.inputData.price,
          "Extra_for_urgent_need": 'not provided',
          "service_title": widget.inputData.title
        }, images).then((value) {
          setState(() {
            isLoading = false;
          });
          if (value?.data['status']) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => GigAnimation(isSuccess: true)),
                (route) => false);
          }
        }).catchError((e) {
          setState(() {
            isLoading = false;
          });
          print(e);
          BaseDio.getDioError(e);
        });
      }
      if (widget.isFromEditGig ?? false) {
        print(images);
        print(widget.myGig?.id);
        await HttpClient().editGig({
          'category': widget.inputData.categoryId,
          "description": widget.inputData.desc,
          "Perhour": widget.inputData.price,
          "Extra_for_urgent_need": 'not provided',
          "service_title": widget.inputData.title
        }, images, widget.myGig!.id!).then((value) {
          setState(() {
            isLoading = false;
          });
          if (value?.data['status']) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => GigAnimation(isSuccess: true)),
              (route) => false,
            );
            // showSuccessDialog("Gig updated successfully");
          }
        }).catchError((e) {
          setState(() {
            isLoading = false;
          });
          print('its coming from gig edit page'
              '');
          BaseDio.getDioError(e);
          // if (e.response != null && e.response.data['errors'].length > 0) {
          //   showAlertDialog(
          //       error: "Please check your email address",
          //       errorType: "Alert");
          // }
        });
      } else {
        await HttpClient().providersignup({
          ...widget.bodyprovider,
          'fcm_token': StorageManager().fcmToken,
          'os': Platform.isAndroid ? 'android' : 'ios',
          'is_provider': true,
          'category': widget.inputData.categoryId,
          "description": widget.inputData.desc,
          "Perhour": widget.inputData.price,
          "Extra_for_urgent_need": 'not provided',
          "service_title": widget.inputData.title,
          
        }, images).then((value) {
          setState(() {
            isLoading = false;
          });
          if (value?.data['status']) {
            var provider = StorageManager();
            provider.accessToken = value?.data['token'];
            provider.userId = value?.data['user']['id'];
            provider.name = widget.bodyprovider['first_name'];
            provider.phone = widget.bodyprovider['phone_number'];
            provider.email = widget.bodyprovider['email'];
            provider.isProvider = true;
            //  provider.isSocialUser = !widget.bodyprovider['social_login_id'].isEmpty();
            provider.nationality = widget.bodyprovider['nationality'];
            provider.language = value?.data['user']['languages'];

            while (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => GigAnimation(isSuccess: true)),
              (route) => false,
            );

            // provider.stripeId =
            //     "" + value?.data['user']['customer_stripe_id'];
          }
        });
      }
    }
  }

  getFileFromUrl(Gigdocument item) {
    String url =
        "https://urbanmalta.com/public/users/user_${item.userid}/documents/${item.fileName}";
    var rng = new Random();
    var tempDir;
    getTemporaryDirectory().then((value) {
      tempDir = value;
      String tempPath = tempDir.path;
      File file =
          new File('$tempPath' + (rng.nextInt(100)).toString() + '.png');
      http.get(Uri.parse(url)).then((value) {
        file.writeAsBytes(value.bodyBytes);
        setState(() {
          images.add(file);
        });
      });
    });
  }

  showSuccessDialog(desc) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return WarningDialogBox(
              title: "Success",
              descriptions: desc,
              buttonTitle: "ok",
              onPressed: () {
                Navigator.pop(context, "1");
                Navigator.pop(context, "1");
              },
              buttonColor: AppColors.app_color,
              icon: Icons.check);
        });
  }

  Future<void> showMaxImageSelectionAlert(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Max Image Selection'),
          content: Text('You can only select up to 3 images.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
