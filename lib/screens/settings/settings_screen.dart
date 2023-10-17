import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kappu/common/customtexts.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/constants/storage_manager.dart';
import 'package:kappu/net/http_client.dart';
import 'package:kappu/provider/userprovider.dart';
import 'package:kappu/screens/faqs/frequently_asked_questions.dart';
import 'package:kappu/screens/gig/Create_first_gig.dart';
import 'package:kappu/screens/login/splash_view.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../helperfunctions/screen_nav.dart';
import '../../net/base_dio.dart';
import '../change_password/ChangePasswordPage.dart';
import 'provider_profile.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  var provider = StorageManager();
  late String imageUrl = provider.userImage;

  bool isLoaded = false;
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'support@urbanmalta.com',
  );

  Future getImage(ImageSource imageSource, bool isVideo) async {
    XFile? image;
    image = await ImagePicker().pickImage(source: imageSource);
    ImageCropper imageCropper = ImageCropper();
    if (image != null && !isVideo) {
      File? croppedFile = await imageCropper.cropImage(
          sourcePath: image.path,
          compressQuality: 50,
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
        try {
          final res = await HttpClient().UpdateUserProfilePic(croppedFile);
          if (res!.data['status']) {
            provider.userImage = res.data['profile_name'];

            imageUrl = res.data['profile_name'];
            isLoaded != isLoaded;
            await provider.init();
            provider = StorageManager();

            setState(() {});

            print(
                "https://urbanmalta.com/public/users/user_${provider.userId}/profile/$imageUrl");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('' + res.data['message'])),
            );
          } else {
            throw Exception("Image Failed");
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error : $e')),
          );
          BaseDio.getDioError(e);
        }
      }
    }
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

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
                    leading: const Icon(Icons.photo_camera, size: 28),
                    title: const Text(
                      "Camera",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera, isVideo);
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
                      getImage(ImageSource.gallery, isVideo);
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

  void ShowFaqDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text(
            'Comming Soon',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteAccount(BuildContext context) async {
    // isLoading = true;

    await HttpClient().deleteAccount().then((loginresponse) {
      // isLoading = false;

      if (loginresponse?.data['status'] == true) {
        logout(context);
      }
    }).catchError((error) {
      // isLoading = false;
      // setState(() {});
    });
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading:  IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
           icon: Icon(Icons.arrow_back_ios_new),
          color: AppColors.iconColor,
        ),
        title: const Text(
          "Settings",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer<UserProvider>(
            builder: (context, loggedinuser, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 25),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          await source(context, false);
                        },
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CircleAvatar(
                                key: UniqueKey(),
                                radius: 50,
                                backgroundImage: provider.userImage.isNotEmpty
                                    ?
                                    // AssetImage('assets/icons/profile_icon.jpg')
                                    NetworkImage(
                                        "https://urbanmalta.com/public/users/user_${provider.userId}/profile/$imageUrl",
                                      )
                                    :
                                    //  AssetImage('assets/icons/prf.png')
                                    const NetworkImage(
                                        'https://urbanmalta.com/public/frontend/images/johnwing-app.png')),
                            Positioned(
                              bottom: 10,
                              right: -10,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                padding: EdgeInsets.all(3),
                                child: Image.asset(
                                  'assets/icons/edit_icon.png',
                                  height: 25,
                                  width: 25,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        provider.name,
                        textAlign: TextAlign.justify,
                        softWrap: true,
                        maxLines: 2,
                        style: const TextStyle(
                          // fontFamily: "Montserrat-Bold",
                          fontSize: 18,
                          color: Color(0xff161D35),
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        provider.email,
                        softWrap: true,
                        maxLines: 1,
                        overflow: TextOverflow
                            .ellipsis, // Add ellipsis when text overflows
                        style: const TextStyle(
                          // fontFamily: "Montserrat-Regular",
                          fontSize: 14,
                          // color: AppColors.text_desc,
                          color: Color(0xff161D35),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ProfileItem(
                    label: "My Profile",
                    iconPath: 'assets/icons/profile_icon.png',
                    onTap: () {
                      changeScreen(
                          context: context, screen: ProviderProfileScreen());
                    }),
                if (!provider.isSocialUser)
                  ProfileItem(
                      // label: "Change Password",
                      label: "Password",
                      // iconPath: 'assets/icons/loc.png',
                      iconPath: 'assets/icons/password_icon.png',
                      onTap: () {
                        changeScreen(
                            context: context, screen: ChangePasswordPage());
                      }),
                if (provider.isProvider)
                  ProfileItem(
                      label: "Add GIG",
                      iconPath: 'assets/icons/addgig.png',
                      onTap: () {
                        Map<String, dynamic> map = {};
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FirstGigPage(
                                    bodyprovider: map, isFromAddGig: true)));
                      }),
                // ProfileItem(
                //     label: "Faq’s",
                //     iconPath: 'assets/icons/loc.png',
                //     onTap: () {
                //       ShowFaqDialog(context);
                //       // changeScreen(
                //       //     context: context, screen: FrequentlyAskedQuestions());
                //     }),
                ProfileItem(
                    label: "Privacy Policy",
                    // iconPath: 'assets/icons/pl.png',
                    iconPath: 'assets/icons/privacy_icon.png',
                    onTap: () {
                      changeScreen(
                          context: context, screen: PrivacyPolicyPage());
                    }),
                ProfileItem(
                    // label: "Help Center",
                    label: "Help ",

                    // iconPath: 'assets/icons/help.png',

                    iconPath: 'assets/icons/help_icon.png',
                    onTap: () {
                      launchUrl(emailLaunchUri);
                      // ShowFaqDialog(context);
                      // changeScreen(
                      //     context: context, screen: HelpCenterQuestions());
                    }),
                // if (provider.isSocialUser)
                //   ProfileItem(
                //       label: "Become a Service Provider",
                //       iconPath: 'assets/icons/deliver-icon.png',
                //       onTap: () {
                //         // showAlertDialog(context);
                //         showDialog(
                //             context: context,
                //             builder: (BuildContext context) {
                //               return WarningDialogBox(
                //                 title: "Switch to Provider Mode",
                //                 descriptions:
                //                     "Are You sure You want to Switch to Provider Mode?",
                //                 buttonTitle: "ok",
                //                 onPressed: () {
                //                   // 4263982640269299

                //                   logout(context);
                //                   Navigator.push(context, MaterialPageRoute(
                //                     builder: (context) {
                //                       return ProviderSignupFirstScreen();
                //                     },
                //                   ));
                //                 },
                //                 icon: Icons.close,
                //               );
                //             });
                //       }),
                const SizedBox(height: 80.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SettingsRoutePage extends ModalRoute<void> {
  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => "";

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      child: loadLayout(context),
    );
  }

  Widget loadLayout(BuildContext context) {
    return const SettingsPage();
  }
}
