import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/models/notification.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

// const String testDevice = "787b9e0b-4f7c-47eb-a0b8-0eb9a7554728";

class NotificationsPage extends ModalRoute<void> {
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
      child: _buildOverlayContent(context),
    );
  }

  TextEditingController searchController = TextEditingController();
  Widget _buildOverlayContent(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: ScreenUtil().setHeight(90),
            color: AppColors.app_color,
            child: Padding(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(15),
                  top: ScreenUtil().setWidth(35)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: ScreenUtil().setWidth(35)),
                      child: Text(
                        'Notifications',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(22)),
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(90),
                    ),
                  ]),
            ),
          ),
          // SizedBox(height: ScreenUtil().setHeight(17)),
          SizedBox(
            height: ScreenUtil().setHeight(590),
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: tempnotifications
                  .map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Container(
                          color:
                              item.viewd ? Colors.white : Colors.blue.shade50,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(children: [
                              CircleAvatar(
                                radius: ScreenUtil().setHeight(30),
                                backgroundImage:
                                    NetworkImage(item.senderpicurl),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: SizedBox(
                                  width: ScreenUtil().setWidth(250),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.notifiationtext,
                                        style: TextStyle(
                                            fontSize: ScreenUtil().setSp(12),
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            height: 1.4),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        item.notificationtime,
                                        style: TextStyle(
                                            fontSize: ScreenUtil().setSp(12),
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500,
                                            height: 1.4),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ]),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),


        ]),
      ),
    );
  }
}
