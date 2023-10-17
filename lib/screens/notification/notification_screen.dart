import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/components/MyAppBar.dart';
import 'package:kappu/constants/storage_manager.dart';
import 'package:kappu/helperfunctions/screen_nav.dart';
import 'package:kappu/models/notification.dart';
import 'package:kappu/models/serializable_model/NotificationModel.dart';
import 'package:kappu/net/http_client.dart';
import 'package:kappu/screens/ProviderScreens/dashboard/provider_home.dart';
import 'package:kappu/screens/home_page/home_screen.dart';
import 'package:kappu/screens/register/register_more.dart';
import 'package:lottie/lottie.dart';
import 'package:path/path.dart';
import 'dart:math' as math;
import '../login/login_screen.dart';
import 'package:kappu/main.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool showNote = true;

  @override
  void initState() {
    super.initState();
  }

  BuildContext? _scaffoldContext;

  Future<bool> _onWillPop() async {
    if (_scaffoldContext != null) {
      Navigator.pushAndRemoveUntil(
        _scaffoldContext!,
        MaterialPageRoute(
          builder: (BuildContext context) => InitialScreen(),
        ),
        (route) => false,
      );
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    _scaffoldContext = context;
    // if(StorageManager().accessToken.isEmpty){
    //   SchedulerBinding.instance.addPostFrameCallback((_) async {
    //     final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(isFromOtherScreen: true)));
    //     if(result=="1"){
    //       setState(() {
    //
    //       });
    //     }
    //
    //   });
    // }
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: const Text(
                "Notifications",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  // fontFamily: "Montserrat-Bold"
                ),
              ),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => InitialScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: AppColors.iconColor,
                  ))
              // const BackButton(
              //   color: AppColors.iconColor,
              // ),
              ),
          // appBar: AppBar(
          //     backgroundColor: Colors.white,
          //     title: Column(
          //       children: [
          //         Text("Notifications",
          //             style: TextStyle(
          //                 fontSize: 20.sp,
          //                 color: Colors.black,
          //                 fontFamily: "Montserrat-Bold")),
          //       ],
          //     )),
          body: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: ScreenUtil().setHeight(590),
                child: FutureBuilder(
                  future: HttpClient().getNotifications(
                    StorageManager().userId.toString(),
                    "Bearer " + StorageManager().accessToken,
                  ),
                  builder: (context,
                      AsyncSnapshot<List<NotificationModel>> response) {
                    if (response.connectionState != ConnectionState.done) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (response.hasData && response.data!.isNotEmpty) {
                      return Stack(children: <Widget>[
                        showNote
                            ? Container(
                                color: Color(0xFFF5F5F5),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Card(
                                        color: AppColors.app_color,
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Account Notifications",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        // fontFamily:
                                                        //     'Montserrat-Bold',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: ScreenUtil()
                                                            .setSp(18)),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        showNote = false;
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.close,
                                                        color: Colors.white),
                                                  )
                                                ],
                                              ),
                                              Text(
                                                'Your general notifications are here. You can find all Your order notifications in the order tab.',
                                                style: TextStyle(
                                                    fontSize:
                                                        ScreenUtil().setSp(13),
                                                    color: Colors.white,
                                                    // fontFamily:
                                                    //     'Montserrat-Regular',
                                                    height: 1.4),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        ' LAST 30 DAYS',
                                        style: TextStyle(
                                            fontSize: ScreenUtil().setSp(13),
                                            color: Color(0xFF7B7D83),
                                            // fontFamily: 'Montserrat-Regular',
                                            height: 1.4),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                        ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          children: response.data!
                              .map(
                                (item) => Padding(
                                  padding: const EdgeInsets.only(bottom: 2.0),
                                  child: Container(
                                    color: Color(0xFFE4E5EA),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: ScreenUtil().setHeight(30),
                                            backgroundImage: const NetworkImage(
                                              'https://urbanmalta.com/public/frontend/images/johnwing-app.png',
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: SizedBox(
                                              width: ScreenUtil().setWidth(250),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    item.title!,
                                                    style: TextStyle(
                                                      fontSize: ScreenUtil()
                                                          .setSp(14),
                                                      color: Colors.black,
                                                      // fontFamily:
                                                      //     'Montserrat-Medium',
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    DateFormat.jm()
                                                        .format(item.createdAt!)
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: ScreenUtil()
                                                          .setSp(12),
                                                      color: Color(0xFF7B7D83),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      // fontFamily:
                                                      //     'Montserrat-Regular',
                                                      height: 1.4,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ]);
                    } else {
                      // No data found
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Stack(
                          children: <Widget>[
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Lottie.asset(
                                      "animation/no-notification.json",
                                      width: MediaQuery.of(context).size.width *
                                          0.90, // Adjust this width to increase the size
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.42,
                                      fit: BoxFit
                                          .contain, // Adjust this based on your requirement
                                      reverse: true,
                                      repeat: true,
                                    ),
                                    const SizedBox(height: 20.0),
                                    const Text(
                                      'No Notifications Yet',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color.fromRGBO(22, 29, 53, 1),
                                        // fontFamily: 'Merriweather',
                                        fontSize: 20,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.normal,
                                        height: 1,
                                      ),
                                    ),
                                    SizedBox(height: 20.0),
                                    const Text(
                                      'The moment you start your journey,',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color.fromRGBO(22, 29, 53, 1),
                                        // fontFamily: 'Cabin',
                                        fontSize: 14,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.normal,
                                        height: 1,
                                      ),
                                    ),
                                    SizedBox(height: 2.0),
                                    const Text(
                                      'updates will start pouring in.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color.fromRGBO(22, 29, 53, 1),
                                        // fontFamily: 'Cabin',
                                        fontSize: 14,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.normal,
                                        height: 1,
                                      ),
                                    ),
                                    const SizedBox(height: 2.0),
                                    const Text(
                                      'Stay tuned for exciting alerts and updates.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color.fromRGBO(22, 29, 53, 1),
                                        // fontFamily: 'Cabin',
                                        fontSize: 14,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.normal,
                                        height: 1,
                                      ),
                                    ),
                                    // SizedBox(height: 20),
                                    // Container(
                                    //   width: 301.5107116699219,
                                    //   height: 53,
                                    //   child: ElevatedButton(
                                    //     onPressed: () {
                                    //       bool isProvider =
                                    //           StorageManager().isProvider;
                                    //       Navigator.push(
                                    //         context,
                                    //         MaterialPageRoute(
                                    //             builder: (context) => isProvider
                                    //                 ? ProviderHomeScreen()
                                    //                 : HomeScreen()),
                                    //       );
                                    //     },
                                    //     style: ElevatedButton.styleFrom(
                                    //       primary: Color.fromRGBO(73, 149, 235, 1),
                                    //       shape: RoundedRectangleBorder(
                                    //         borderRadius: BorderRadius.circular(15),
                                    //       ),
                                    //       shadowColor:
                                    //           Color.fromRGBO(241, 246, 255, 1),
                                    //       elevation: 5,
                                    //     ),
                                    //     child: Text(
                                    //       'Explore GiGs',
                                    //       textAlign: TextAlign.left,
                                    //       style: TextStyle(
                                    //         color: Color.fromRGBO(255, 255, 255, 1),
                                    //         fontFamily: 'Hind Siliguri',
                                    //         fontSize: 16,
                                    //         letterSpacing: 0,
                                    //         fontWeight: FontWeight.normal,
                                    //         height: 1.0625,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ]),
          ),
        ));
  }
}
