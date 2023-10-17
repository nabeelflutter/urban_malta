import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/models/notification.dart';

class NotificationsPageProvider extends StatefulWidget {
  const NotificationsPageProvider({Key? key}) : super(key: key);

  @override
  _NotificationsPageProviderState createState() =>
      _NotificationsPageProviderState();
}

class _NotificationsPageProviderState extends State<NotificationsPageProvider> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: ScreenUtil().setHeight(90),
            color: AppColors.app_color,
            child: Padding(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(75),
                  top: ScreenUtil().setWidth(35)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                  ]),
            ),
          ),
          // SizedBox(height: ScreenUtil().setHeight(17)),
          SizedBox(
            height: ScreenUtil().setHeight(590),
            child: ListView(
              shrinkWrap: true,
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
