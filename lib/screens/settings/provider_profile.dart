import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_stripe/flutter_stripe.dart' hide Card;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kappu/common/validation_dialogbox.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/components/ProviderItem.dart';
import 'package:kappu/constants/storage_manager.dart';
import 'package:kappu/models/serializable_model/AddOrderResponse.dart';
import 'package:kappu/net/base_dio.dart';
import 'package:kappu/net/http_client.dart';
import 'package:kappu/screens/login/splash_view.dart';
import 'package:kappu/screens/settings/settings_screen.dart';
import 'package:http/http.dart' as http;
import '../../common/customtexts.dart';
import '../../common/save_dialogbox.dart';
import '../../components/MyAppBar.dart';

class ProviderProfileScreen extends StatefulWidget {
  @override
  _ProviderProfileScreenState createState() => _ProviderProfileScreenState();
}

class _ProviderProfileScreenState extends State<ProviderProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future getImage(ImageSource imageSource, context, bool isVideo) async {
    XFile? image;
    image = await ImagePicker().pickImage(source: imageSource);
    ImageCropper imageCropper = ImageCropper();
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
      if (croppedFile != null) {
        HttpClient()
            .UpdateUserProfilePic(croppedFile)
            .then((value) => {
                  // setState(() {
                  //   this.loading = false;
                  // }),
                  print(value),
                  if (value!.data['status'])
                    {
                      StorageManager().userImage = value!.data['profile_name'],
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('' + value!.data['message'])),
                      ),
                      setState(() {})
                    }
                })
            .catchError((e) {
          // setState(() {
          //   this.loading = true;
          // });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error : $e')),
          );
          BaseDio.getDioError(e);
        });
      }
    }
    Navigator.pop(context);
  }

  Future source(BuildContext mContext, bool isVideo) async {
    return showDialog(
        context: mContext,
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
                            getImage(ImageSource.camera, context, isVideo);
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
                            getImage(ImageSource.gallery, context, isVideo);
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

  List<bool> checkBoxStates = [false, false, false, false];

  Future<void> deleteAccount(BuildContext context) async {
    // isLoading = true;
    final token = StorageManager().accessToken;
    final int userID = StorageManager().userId;
    const url = 'https://urbanmalta.com/api/user/deleteaccount';
    // final token = '1336|OGWrOCFWZUHYNAWPaTPM28yKOLSQElcLzE5HPe2g';

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final body = {
      'user_id': userID.toString(),
    };

    final jsonBody = json.encode(body);
    print(body);
    print(headers);
    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: jsonBody);
      if (response.statusCode == 200) {
        print('API request successful');
      } else {
        logout(context);
        print(response.body);
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      // print(error);
      throw Exception('Failed to fetch data');
    }
    // await HttpClient().deleteAccount().then((loginresponse) {
    //   // isLoading = false;

    //   if (loginresponse?.data['status'] == true) {
    //     logout(context);
    //   }
    // }).catchError((error) {
    //   // isLoading = false;
    //   // setState(() {});
    // }
    // );
  }

  void logout(BuildContext context) {
    StorageManager().clear();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return SplashView();
    }), (r) {
      return false;
    });
    Phoenix.rebirth(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: MyAppBar(title: "Profile detail"),
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Profile",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
           leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back_ios_new,color: AppColors.iconColor,))

        ),
        body: Container(
          // color: Colors.grey.withOpacity(0.1),
          color: Color(0xfff4f4f6),
          child: Column(
            children: [
              // const Divider(
              //   height: 0.5,
              //   color: Colors.grey,
              // ),
              // Container(
              //     padding: const EdgeInsets.only(
              //         left: 20, right: 20, top: 32, bottom: 32),
              //     width: double.infinity,
              //     color: Colors.white,
              //     child: Row(
              //       children: [
              //         InkWell(
              //           child: CircleAvatar(
              //               radius: 40,
              //               backgroundImage: StorageManager().userImage.length >
              //                       0
              //                   ? NetworkImage(
              //                       "https://urbanmalta.com/public/users/user_${StorageManager().userId}/profile/${StorageManager().userImage}")
              //                   : NetworkImage(
              //                       'https://urbanmalta.com/public/frontend/images/johnwing-app.png')),
              //           onTap: () async {
              //             await source(context, false);
              //           },
              //         ),
              //         SizedBox(
              //           width: 15,
              //         ),
              //         Expanded(
              //             child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             InkWell(
              //                 onTap: () {
              //                   showDialog(
              //                       context: context,
              //                       builder: (BuildContext context) {
              //                         return SaveDialogBox(
              //                           buttonTitle: 'Save',
              //                           buttonColor: AppColors.app_color,
              //                           onPressed: (name) {
              //                             HttpClient()
              //                                 .updateName(name)
              //                                 .then((value) {
              //                               print(value);
              //                               StorageManager().name = name;
              //                               setState(() {});
              //                             }).catchError((e) {
              //                               ScaffoldMessenger.of(context)
              //                                   .showSnackBar(
              //                                 SnackBar(
              //                                     content: Text('Error : $e')),
              //                               );
              //                               BaseDio.getDioError(e);
              //                             });
              //                             Navigator.pop(context);
              //                           },
              //                         );
              //                       });
              //                 },
              //                 child: Text(
              //                   StorageManager().name,
              //                   maxLines: 3,
              //                   style: TextStyle(
              //                       color: Colors.black,
              //                       fontSize: 24,
              //                       fontWeight: FontWeight.bold),
              //                 )),
              //             SizedBox(
              //               height: 5,
              //             ),
              //             Text(
              //               StorageManager().email,
              //               maxLines: 3,
              //               style: TextStyle(
              //                   color: AppColors.color_7B7D83,
              //                   fontSize: 16,
              //                   fontWeight: FontWeight.normal),
              //             ),
              //           ],
              //         ))
              //       ],
              //     )),

              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView(
                  padding: EdgeInsets.all(20),
                  shrinkWrap: true,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xfff4f4f6),
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: Row(
                        children: [
                          // Image.asset('assets/icons/prf.png', scale: 1.0),
                          // SizedBox(
                          //   width: 20,
                          // ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Full name',
                                maxLines: 3,
                                style: TextStyle(
                                    color: AppColors.color_7B7D83,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                StorageManager().name,
                                maxLines: 3,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //       color: Color(0xfff4f4f6),
                    //       borderRadius: BorderRadius.circular(10)),
                    //   padding: const EdgeInsets.only(
                    //       left: 20, right: 20, top: 10, bottom: 10),
                    //   child: Row(
                    //     children: [
                    //       // Image.asset('assets/icons/prf.png', scale: 1.0),
                    //       // SizedBox(
                    //       //   width: 20,
                    //       // ),
                    //       Expanded(
                    //           child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Text(
                    //             'Last name',
                    //             maxLines: 3,
                    //             style: TextStyle(
                    //                 color: AppColors.color_7B7D83,
                    //                 fontSize: 14,
                    //                 fontWeight: FontWeight.normal),
                    //           ),
                    //           SizedBox(
                    //             height: 5,
                    //           ),
                    //           Text(
                    //             StorageManager().lastname,
                    //             maxLines: 3,
                    //             style: TextStyle(
                    //                 color: Colors.black,
                    //                 fontSize: 18,
                    //                 fontWeight: FontWeight.normal),
                    //           ),
                    //         ],
                    //       ))
                    //     ],
                    //   ),
                    // ),

                    // SizedBox(
                    //   height: 20,
                    // ),
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xfff4f4f6),
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: Row(
                        children: [
                          // Image.asset('assets/icons/email.png', scale: 1.0),
                          // SizedBox(
                          //   width: 20,
                          // ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "email",
                                maxLines: 3,
                                style: TextStyle(
                                    color: AppColors.color_7B7D83,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                StorageManager().email,
                                maxLines: 3,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xfff4f4f6),
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: Row(
                        children: [
                          // Image.asset('assets/icons/call.png', scale: 1.0),
                          // SizedBox(
                          //   width: 20,
                          // ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Phone Number",
                                maxLines: 3,
                                style: TextStyle(
                                    color: AppColors.color_7B7D83,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                StorageManager().phone.toString(),
                                maxLines: 3,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 15,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // showAlertDialog(context);
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return WarningDialogBox(
                                    title: " ",
                                    descriptions:
                                        "Are You sure You want to Logout?",
                                    buttonTitle: "Yes",
                                    onPressed: () {
                                      Navigator.pop(context);
                                      logout(context);
                                    },
                                    icon: Icons.close,
                                  );
                                });
                          },
                          child: Row(
                            children: [
                              Container(
                                child: Image.asset(
                                  'assets/icons/logout_icon.png',
                                  color: Colors.red,
                                  height: 25,
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const Text(
                                'Log Out',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                        // ProfileItem(
                        //     // label: "Logout",
                        //     label: "Log Out",
                        //     color: Color.fromARGB(255, 187, 34, 52),
                        //     // iconPath: 'assets/icons/exit.png',
                        //     iconPath: 'assets/icons/logout_icon.png',
                        //     onTap: () {
                        //       // showAlertDialog(context);
                        //       showDialog(
                        //           context: context,
                        //           builder: (BuildContext context) {
                        //             return WarningDialogBox(
                        //               title: "Logout?",
                        //               descriptions:
                        //                   "Are You sure You want to Logout?",
                        //               buttonTitle: "ok",
                        //               onPressed: () {
                        //                 Navigator.pop(context);
                        //                 logout(context);
                        //               },
                        //               icon: Icons.close,
                        //             );
                        //           });
                        //     }
                        //     ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: const Divider(
                            thickness: 1,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            // showDialog(
                            //     context: context,
                            //     builder: (BuildContext context) {
                            //       return WarningDialogBox(
                            //         title: "Delete?",
                            //         descriptions:
                            //             "Are You sure You want to Delete this account?",
                            //         buttonTitle: "ok",
                            //         onPressed: () {
                            //           deleteAccount(context);
                            //         },
                            //         icon: Icons.close,
                            //       );
                            //     });

                            showDeleteBottom();
                          },
                          child: Row(
                            children: [
                              Container(
                                child: Image.asset(
                                  'assets/icons/bottom_del_icon.png',
                                  color: Colors.red,
                                  height: 25,
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const Text(
                                'Delete Account',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),

                        // ProfileItem(
                        //     label: "Delete Account",
                        //     iconPath: 'assets/icons/exit.png',
                        //     onTap: () {
                        //       showDialog(
                        //           context: context,
                        //           builder: (BuildContext context) {
                        //             return WarningDialogBox(
                        //               title: "Delete?",
                        //               descriptions:
                        //                   "Are You sure You want to Delete this account?",
                        //               buttonTitle: "ok",
                        //               onPressed: () {
                        //                 deleteAccount(context);
                        //               },
                        //               icon: Icons.close,
                        //             );
                        //           });
                        //     }
                        // ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  void showDeleteBottom() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.85,
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // IconButton(onPressed: () {}, icon: Icon(Icons.cancel)),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 15),
                            child: Image.asset(
                                'assets/icons/bottom_cross_icon.png'),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                        ),
                        const Text(
                          'Help',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Delete account',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: Column(
                        children: [
                          const Divider(
                            thickness: 1,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: 4,
                            itemBuilder: (BuildContext context, int i) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        checkBoxStates[i] = !checkBoxStates[i];
                                      });
                                    },
                                    child: Text(
                                      [
                                        'The Service is too expensive',
                                        'I am no longer using my account',
                                        'I want to change my phone number',
                                        'I don\'t understand how to use the service',
                                      ][i],
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      checkBoxStates[i] = !checkBoxStates[i];
                                    });
                                  },
                                  icon: Icon(
                                    checkBoxStates[i]
                                        ? Icons.check_box
                                        : Icons.check_box_outline_blank,
                                    color: checkBoxStates[i]
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            height: 100,
                            color: Color(0xfff9fafc),
                            child: Stack(
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 15),
                                    border: InputBorder.none,
                                    hintText: "Describe your issue",
                                    hintStyle: TextStyle(fontSize: 20),
                                  ),
                                  onChanged: (text) {
                                    // Handle text changes if needed
                                  },
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text(
                                      'I would like to delete my account',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    backgroundColor: Color(0xffd82636)),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return WarningDialogBox(
                                          title: "Delete?",
                                          descriptions:
                                              "Are You sure You want to Delete this account?",
                                          buttonTitle: "ok",
                                          onPressed: () {
                                            deleteAccount(context);
                                          },
                                          icon: Icons.close,
                                        );
                                      });
                                },
                                child: const Text(
                                  'DELETE ACCOUNT',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w400),
                                )),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
