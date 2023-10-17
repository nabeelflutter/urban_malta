import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/common/customtexts.dart';
import 'package:kappu/models/serializable_model/booking.dart';
import 'package:kappu/net/http_client.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../models/serializable_model/provider_profile.dart';
import '../../../provider/userprovider.dart';
import '../../profilepage/profile_page.dart';

class ServiceProviderOrUserSummary extends StatelessWidget {
  final Booking booking;
  const ServiceProviderOrUserSummary({Key? key, required this.booking})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, user, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customtext(
            buttontext:
                'Service ${user.token != '' ? 'Provider ' : 'Buyer '}Details',
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          10.verticalSpace,
          user.token != ""
              ? FutureBuilder(
                  future: HttpClient().getproviderprofile(booking.providerid),
                  builder: (context,
                      AsyncSnapshot<ProviderProfile> providerprofile) {
                    if (providerprofile.connectionState !=
                        ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return GestureDetector(
                      onTap: () {
                        pushDynamicScreen(context,
                            screen: ProviderProfilePageScreen(
                                providerProfile: providerprofile.data!),
                            withNavBar: false);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customtext(
                                buttontext: providerprofile.data!.firstname,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              5.verticalSpace,
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow.shade800,
                                  ),
                                  customtext(
                                    buttontext:
                                        " ${((providerprofile.data!.averagerating * pow(10.0, 1)).round().toDouble() / pow(10.0, 1)).toString()}   ",
                                    color: Colors.yellow.shade800,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                  customtext(
                                    buttontext:
                                        '(${providerprofile.data!.totalreviews}) Ratings',
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ],
                              )
                            ],
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: ScreenUtil().setHeight(20),
                            backgroundImage: NetworkImage(
                              providerprofile.data!.profilepicture != null
                                  ? providerprofile.data!.profilepicture!
                                  : 'https://urbanmalta.com/public/frontend/images/johnwing-app.png',
                            ),
                          )
                        ],
                      ),
                    );
                  })
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customtext(
                          buttontext:
                              booking.userfname + " " + booking.userlname,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        5.verticalSpace,
                        customtext(
                          buttontext: booking.useremail,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ],
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: ScreenUtil().setHeight(20),
                      backgroundImage: const NetworkImage(
                        'https://urbanmalta.com/public/frontend/images/johnwing-app.png',
                      ),
                    )
                  ],
                ),
        ],
      ),
    );
  }
}
