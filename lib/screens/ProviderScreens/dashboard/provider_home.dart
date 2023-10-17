import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:kappu/constants/storage_manager.dart';
import 'package:kappu/screens/Transaction/statisic.dart';
import 'package:kappu/screens/location/choose_location_screen.dart';
import 'package:kappu/screens/provider_reviews/provider_reviews.dart';
import 'package:kappu/screens/register/register_more.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/serializable_model/review.dart';
import '../../../net/http_client.dart';
import '../../current_location_screen.dart';
import '../../gig/Create_first_gig.dart';
import '../../gig/GigListPage.dart';
import '../../notification/notification_screen.dart';
import '../../settings/provider_profile.dart';
import 'widget/home_item.dart';

class ProviderHomeScreen extends StatefulWidget {
  const ProviderHomeScreen({Key? key}) : super(key: key);

  @override
  _ProviderHomeScreenState createState() => _ProviderHomeScreenState();
}

class _ProviderHomeScreenState extends State<ProviderHomeScreen> {
  double getAverageRating(List<double> ratings) {
    double totalRating = 0;
    int count = 0;

    for (var rating in ratings) {
      totalRating += rating;
      count++;
    }

    if (count > 0) {
      return totalRating / count;
    } else {
      return 0;
    }
  }

  late Future<List<Rating>> _future;
  late Future<Map<String, dynamic>> _futureData;
  // late Future<Map<String, dynamic>> _providerData;

  @override
  void initState() {
    // TODO: implement initState
    // getLoc();
    _future = HttpClient().getUserReviews(StorageManager().userId.toString());
    super.initState();
    _futureData = postDataWithToken();
    // fetchData();
  }

  String loc = 'Malta'; // Provide a default value
  Future<void> getLoc() async {
    print("get loc");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString('currentLocation') == null) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return ChooseLocationScreen(password: 'password');
        },
      ));
    } else {
      setState(() {
        loc = preferences.getString('currentLocation')!;
      });
    }
  }

  // Future<void> fetchData() async {
  //   try {
  //     ProlistResponse = await postDataWithToken();

  //     print(ProlistResponse);
  //   } catch (error) {
  //     print(error);
  //   }
  // }

  late Map<String, dynamic> PromapResponse;
  late Map<String, dynamic> ProlistResponse = {};

  Future<Map<String, dynamic>> postDataWithToken() async {
    //  const url = '${Constants.BASE_URL}api/wallet/serviceprovider/stats';
    final token = StorageManager().accessToken;
    final int userID = StorageManager().userId;
    const url = 'https://urbanmalta.com/api/wallet/serviceprovider/stats';
    // final token = '1336|OGWrOCFWZUHYNAWPaTPM28yKOLSQElcLzE5HPe2g';

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final body = {
      'user_id': userID.toString(),
      'service_provider_id': userID.toString(),
    };

    final jsonBody = json.encode(body);

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: jsonBody);
      if (response.statusCode == 200) {
        // print('API request successful');

        setState(() {
          PromapResponse = json.decode(response.body);
          ProlistResponse = PromapResponse['data'];

          print(ProlistResponse);
        });
        return ProlistResponse;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      print(error);
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
      // Set your desired color
    );
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Container(
            //         height: 40,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(30),
            //           color: const Color(0xfff1f6fb),
            //         ),
            //         // child: Row(
            //         //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //         //   children: [
            //         //     const Padding(
            //         //       padding: EdgeInsets.only(left: 8.0),
            //         //       child: Icon(
            //         //         Icons.location_on,
            //         //         color: Colors.blue,
            //         //       ),
            //         //     ),
            //         //     Padding(
            //         //       padding: const EdgeInsets.only(right: 8.0),
            //         //       child: Text(
            //         //         loc ?? "Malta",
            //         //         // Handle text overflow
            //         //         style: const TextStyle(
            //         //           fontSize: 14,
            //         //           color: Color(0xff8189B0),
            //         //         ),
            //         //       ),
            //         //     ),
            //         //   ],
            //         // ),
            //       ),
            //       const SizedBox(
            //         width: 20,
            //       ),
            //       SizedBox(
            //         height: 40,
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //           children: [
            //             GestureDetector(
            //               onTap: () {
            //                 // Add the action you want to perform when the first icon is tapped.
            //                 // For example, you can navigate to a new screen or show a dialog.
            //                 Navigator.push(context, MaterialPageRoute(
            //                   builder: (context) {
            //                     return const NotificationScreen();
            //                   },
            //                 ));
            //               },
            //               child: Container(
            //                 width: 25,
            //                 decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(5),
            //                   // border: Border.all(width: 0.5, color: Colors.grey),
            //                 ),
            //                 child: Image.asset(
            //                   'assets/icons/notification.png',
            //                   height: 25,
            //                 ),
            //               ),
            //             ),
            //             const SizedBox(
            //               width: 20,
            //             ),
            //             GestureDetector(
            //                 onTap: () {
            //                   // Add the action you want to perform when the image is tapped.
            //                   // For example, you can navigate to a new screen or show a dialog.
            //                   Navigator.push(context, MaterialPageRoute(
            //                     builder: (context) {
            //                       return ProviderProfileScreen();
            //                     },
            //                   ));
            //                 },
            //                 child: Container(
            //                   width:
            //                       30, // Adjust the width and height to your needs
            //                   height: 30,
            //                   decoration: BoxDecoration(
            //                     shape: BoxShape.circle,
            //                     border:
            //                         Border.all(width: 0.5, color: Colors.grey),
            //                   ),
            //                   padding: StorageManager().userImage.isNotEmpty
            //                       ? EdgeInsets.zero
            //                       : EdgeInsets.symmetric(
            //                           vertical: 5, horizontal: 5),
            //                   child: ClipOval(
            //                     child: StorageManager().userImage.isNotEmpty
            //                         ? Image.network(
            //                             "https://urbanmalta.com/public/users/user_${StorageManager().userId}/profile/${StorageManager().userImage}",
            //                             fit: BoxFit
            //                                 .cover, // Ensure the image covers the circular container
            //                           )
            //                         : Image.asset(
            //                             'assets/icons/profile_icon.png',
            //                             fit: BoxFit
            //                                 .cover, // Similarly, ensure the placeholder image covers the container
            //                           ),
            //                   ),
            //                 ))
            //           ],
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            Expanded(
                child: ListView(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 20, top: 30),
              shrinkWrap: true,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color(0xfff1f6fb),
                      ),
                      // child: Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     const Padding(
                      //       padding: EdgeInsets.only(left: 8.0),
                      //       child: Icon(
                      //         Icons.location_on,
                      //         color: Colors.blue,
                      //       ),
                      //     ),
                      //     Padding(
                      //       padding: const EdgeInsets.only(right: 8.0),
                      //       child: Text(
                      //         loc ?? "Malta",
                      //         // Handle text overflow
                      //         style: const TextStyle(
                      //           fontSize: 14,
                      //           color: Color(0xff8189B0),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Add the action you want to perform when the first icon is tapped.
                              // For example, you can navigate to a new screen or show a dialog.
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return const NotificationScreen();
                                },
                              ));
                            },
                            child: Container(
                              width: 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                // border: Border.all(width: 0.5, color: Colors.grey),
                              ),
                              child: Image.asset(
                                'assets/icons/notification.png',
                                height: 25,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                              onTap: () {
                                // Add the action you want to perform when the image is tapped.
                                // For example, you can navigate to a new screen or show a dialog.
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return ProviderProfileScreen();
                                  },
                                ));
                              },
                              child: Container(
                                width:
                                    30, // Adjust the width and height to your needs
                                height: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 0.5, color: Colors.grey),
                                ),
                                padding: StorageManager().userImage.isNotEmpty
                                    ? EdgeInsets.zero
                                    : EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
                                child: ClipOval(
                                  child: StorageManager().userImage.isNotEmpty
                                      ? Image.network(
                                          "https://urbanmalta.com/public/users/user_${StorageManager().userId}/profile/${StorageManager().userImage}",
                                          fit: BoxFit
                                              .cover, // Ensure the image covers the circular container
                                        )
                                      : Image.asset(
                                          'assets/icons/profile_icon.png',
                                          fit: BoxFit
                                              .cover, // Similarly, ensure the placeholder image covers the container
                                        ),
                                ),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    'Hello, ${StorageManager().name}👋',
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                        color: Color(0xff2E3E5C)),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 125,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 5),
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                            colors: [Color(0xffA8C0FF), Color(0xff3F2B96)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   'Hello, ${StorageManager().name}',
                            //   style: const TextStyle(
                            //       fontSize: 25,
                            //       fontWeight: FontWeight.w800,
                            //       color: Color(0xff2E3E5C)),
                            // ),

                            // ... your text content ...

                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Ready to Showcase\nyour Skills?',
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),

                            const SizedBox(
                              height: 10,
                            ),
                            ProlistResponse['balance'] != null
                                ? Row(
                                    children: [
                                      const Text(
                                        'Your Balance :',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff2E3E5C)),
                                      ),
                                      Text(
                                        ' €${ProlistResponse['balance']}',
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff2E3E5C)),
                                      ),
                                    ],
                                  )
                                : const SizedBox(
                                    height: 5,
                                    width: 5,
                                  ),

                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Overall Rating: ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff2E3E5C)),
                                ),
                                FutureBuilder(
                                  future: _future,
                                  builder: (context,
                                      AsyncSnapshot<List<Rating>> ratings) {
                                    if (ratings.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: SizedBox(
                                            height: 2,
                                            width: 2,
                                            child: CircularProgressIndicator(
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                      );
                                    } else if (ratings.connectionState ==
                                            ConnectionState.done &&
                                        ratings.hasData == true) {
                                      List<double> reviewList = [];

                                      for (var element in ratings.data!) {
                                        reviewList
                                            .add(double.parse(element.rating!));
                                      }
                                      return Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          RatingBar.builder(
                                            ignoreGestures: true,
                                            initialRating:
                                                getAverageRating(reviewList),
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemSize: 15,
                                            itemPadding:
                                                const EdgeInsets.only(right: 1),
                                            itemBuilder: (context, _) =>
                                                const Icon(Icons.star,
                                                    color: Colors.amber),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                        ],
                                      );
                                    } else if (ratings.hasError) {
                                      return const Center(
                                          child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: SizedBox(
                                            height: 10,
                                            width: 10,
                                            child: CircularProgressIndicator(
                                              color: Colors.blue,
                                            )),
                                      ));
                                    } else {
                                      return const Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(15.0),
                                          child: SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                            // Text(
                            //   'Current Balance : ',
                            //   style: TextStyle(
                            //       fontSize: ScreenUtil().setSp(16),
                            //       color: Colors.white,
                            //       fontFamily: 'Montserrat-Medium',
                            //       height: 1.4),
                            // ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: -10,
                        bottom: 0,
                        child: Image.asset(
                          'assets/images/pro_home.png',
                          // fit: BoxFit.cover,
                          height: 95,
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Seller mode  ",
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 16,
                                  fontFamily: 'Montserrat-Bold'),
                            ),
                            CustomToggleButton(
                              isSelected: true,
                              onChange: (value) {},
                            )
                          ],
                        ),
                      ),
                    ),*/
                    20.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: HomeItem(
                            title: 'Statistics',
                            imagePath: 'assets/images/j19.png',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const Statistic();
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                            child: HomeItem(
                          title: 'Create A GIG',
                          imagePath: 'assets/images/j20.png',
                          onTap: () {
                            // Navigator.push(context, MaterialPageRoute(
                            //   builder: (context) {
                            //     return const GigListPage();
                            //   },
                            // ));
                            // Map<String, dynamic> map = {};
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => RegisterMore(
                            //             bodyprovider: map,
                            //             isFromAddGig: true
                            // )));
                            /////////////////////////
                            Map<String, dynamic> map = {};
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FirstGigPage(
                                        bodyprovider: map,
                                        isFromAddGig: true)));

                            ////////////////////////
                          },
                        )),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                            child: HomeItem(
                          title: 'Check Your GIGs',
                          imagePath: 'assets/images/j21.png',
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return const GigListPage();
                              },
                            ));
                          },
                        )),
                        const SizedBox(width: 20),
                        Expanded(
                            child: HomeItem(
                          title: 'Ratings and Reviews',
                          imagePath: 'assets/images/j22.png',
                          onTap: () {
                            print('aaa');
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return ProviderReviewsPage(
                                    providerid: StorageManager().userId,
                                    averagerating: 5.0);
                              },
                            ));
                            // Map<String, dynamic> map = {};
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => RegisterMore(
                            //             bodyprovider: map,
                            //             isFromAddGig: true)));
                          },
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    FutureBuilder(
                      future: _futureData,

                      // print(postDataWithToken);
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final dynamic data = snapshot.data!;
                          print('ajay${data}');
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: Container(
                                    height: 75,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: const Color(0xffDEE7FF)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          // '€47',
                                          '€${data['balance']}',
                                          style: const TextStyle(
                                              fontSize: 28,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff3B6DF1)),
                                        ),
                                        const Text(
                                          'Personal Balance',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff7F8E9D)),
                                        )
                                      ],
                                    ),
                                  )),
                                  const SizedBox(width: 20),
                                  Expanded(
                                      child: Container(
                                    height: 75,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: const Color(0xffD0F6E8)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          // '€47',
                                          '${data['total_bookings']}',
                                          style: const TextStyle(
                                              fontSize: 28,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff21B882)),
                                        ),
                                        const Text(
                                          'Total Bookings',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff7F8E9D)),
                                        )
                                      ],
                                    ),
                                  )),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 75,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: const Color(0xffF6DFCF)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            // '€47',
                                            '€${data['booking_amount_month']}',
                                            style: const TextStyle(
                                                fontSize: 28,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xffF37B20)),
                                          ),
                                          const Text(
                                            'Earning This Month',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff7F8E9D)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Container(
                                      height: 75,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: const Color(0xffFFD5E9)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            // '€47',
                                            '€${data['pending_payments']}',
                                            style: const TextStyle(
                                                fontSize: 28,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xffD93A87)),
                                          ),
                                          const Text(
                                            'Payment On Hold',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff7F8E9D)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          );
                        } else {
                          return Center(
                            child: Container(),
                          );
                        }
                      },
                    ),
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
