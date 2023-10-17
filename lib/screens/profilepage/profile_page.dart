import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/common/flushbar.dart';
import 'package:kappu/models/serializable_model/provider_profile.dart';
import 'package:kappu/screens/chats/chat_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../net/http_client.dart';
import '../../provider/userprovider.dart';
import '../provider_reviews/provider_reviews.dart';

class ProviderProfilePageScreen extends ModalRoute<void> {
  ProviderProfile? providerProfile;

  ProviderProfilePageScreen({this.providerProfile});
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

  List<bool> isSelected = [true, false, false];

  Widget _buildOverlayContent(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.only(right: ScreenUtil().setWidth(290)),
            child: CircleAvatar(
              backgroundColor: Colors.blue,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Center(
            child: Stack(
              children: [
                ClipOval(
                  child: Material(
                    color: Colors.transparent,
                    child: Ink.image(
                      image: NetworkImage(
                          'https://urbanmalta.com/public/frontend/images/johnwing-app.png'),
                      fit: BoxFit.cover,
                      width: 128,
                      height: 128,
                      child: InkWell(onTap: () {}),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Column(
            children: [
              Text(
                "providerProfile.firstname",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil().setSp(22)),
              ),
              const SizedBox(height: 4),
              Text(
                "providerProfile.email",
                style: const TextStyle(color: Colors.grey),
              )
            ],
          ),
          const SizedBox(height: 24),
          Consumer<UserProvider>(
            builder: (context, loggedinuser, child) => Center(
                child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                onPrimary: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text('Message'),
              onPressed: () async {},
            )),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: MaterialButton(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => ProviderReviewsPage(
                    //             providerid: providerProfile.id,
                    //             averagerating: (providerProfile.averagerating *
                    //                         pow(10.0, 1))
                    //                     .round()
                    //                     .toDouble() /
                    //                 pow(10.0, 1))));
                  },
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow.shade800,
                          ),
                          Text(
                            "a",
                            style: TextStyle(
                                color: Colors.yellow.shade800,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(20)),
                          ),
                        ],
                      ),
                      SizedBox(height: ScreenUtil().setHeight(6)),
                      Text(
                        'Average Rating',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
              ),
              buildDivider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: buildButton(context, "0", 'Total Ratings '),
              ),
              buildDivider(),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: buildButton(context, "0", 'Total Services'),
              ),
            ],
          ),
          const SizedBox(height: 48),
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(15),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: ScreenUtil().setHeight(4)),
                Text(
                  "providerProfile.email",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(14),
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      height: 1.4),
                ),
                SizedBox(height: ScreenUtil().setHeight(16)),
                Text(
                  'Phone Number',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(15),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: ScreenUtil().setHeight(4)),
                Text(
                  "providerProfile.phno",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(14),
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      height: 1.4),
                ),
                SizedBox(height: ScreenUtil().setHeight(16)),
                Text(
                  'Skills',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(15),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: ScreenUtil().setHeight(4)),
                Text(
                  "providerProfile.skill",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(14),
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      height: 1.4),
                ),
                SizedBox(height: ScreenUtil().setHeight(16)),
                Text(
                  'Bio',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(15),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: ScreenUtil().setHeight(4)),
                Text(
                  "Bio not set",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(14),
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      height: 1.4),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildDivider() => SizedBox(
        height: ScreenUtil().setHeight(30),
        child: const VerticalDivider(
          thickness: 2,
        ),
      );

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(20)),
            ),
            SizedBox(height: ScreenUtil().setHeight(6)),
            Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.grey.shade600),
            ),
          ],
        ),
      );
}
