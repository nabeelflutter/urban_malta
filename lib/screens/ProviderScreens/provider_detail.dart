import 'package:flutter/material.dart';
import 'package:flutter_credit_card/extension.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/constants/storage_manager.dart';
import 'package:kappu/models/recommended.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kappu/screens/ProviderScreens/item_recommended.dart';
import 'package:kappu/screens/ProviderScreens/item_review.dart';
import 'package:kappu/screens/ProviderScreens/order_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/serializable_model/provider_detail_model.dart';
import '../../models/serializable_model/review.dart';
import '../../net/http_client.dart';
import '../login/login_screen.dart';
import 'package:intl/intl.dart';

class ProviderDetailScreen extends StatefulWidget {
  ///replace code from here to end of this file
  final int id;
  String? location;

  ProviderDetailScreen({this.location, required this.id});

  @override
  _ProviderDetailScreenState createState() => _ProviderDetailScreenState();
}

class _ProviderDetailScreenState extends State<ProviderDetailScreen> {
  double getAverageRating(List<double> ratings) {
    double totalRating = 0;
    int count = 0;

    for (var rating in ratings) {
      if (rating != null) {
        totalRating += rating;
        count++;
      }
    }

    if (count > 0) {
      return totalRating / count;
    } else {
      return 0;
    }
  }

  double getRatingPercentageForRating(int starRating, List<Rating> ratings) {
    // Calculate the count of reviews for the given star rating
    int reviewCount = ratings
        .where((rating) => rating.rating == starRating.toString())
        .length;

    // Calculate the total count of reviews
    int totalCount = ratings.length;

    // Calculate the rating percentage for the given star rating
    double ratingPercentage = reviewCount / totalCount;

    return ratingPercentage;
  }

  // late Future<List<Rating>> future;
  bool basicOrAdvance = false;
  @override
  void initState() {
    super.initState();
  }

  Future<List<DataModel>> fetchDataList(
      {required int categoryId, required int userId}) async {
    final url = Uri.parse('https://urbanmalta.com/api/services/recommended');
    final body = {
      'category_id': categoryId.toString(),
      'user_id': userId.toString(),
    };

    final response = await http.post(url, body: body);

    if (response.statusCode == 200) {
      print('response success');
      final jsonData = jsonDecode(response.body);
      if (jsonData is List) {
        print('another success');
        return jsonData
            .map<DataModel>((json) => DataModel.fromJson(json))
            .toList();
      }
    }

    return []; // Return an empty list if fetching or parsing fails
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: AppColors.app_bg,
        body: FutureBuilder(
            future: HttpClient().getServiceProviderDetail("${widget.id}"),
            builder:
                (context, AsyncSnapshot<List<ProviderDetailModel>> response) {
              if (response.connectionState != ConnectionState.done) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                //  print('catii : ${widget.id} user id ${response.data![0].userId}');
                if (response.data!.length > 0) {
                  return Container(
                    color: AppColors.color_f2f7fd,
                    child: Stack(
                      children: [
                        ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            Container(
                              width: double.infinity,
                              height: 250,
                              child:
                                  getDataImage(response.data![0].gigdocument!),
                            ),
                            Container(
                              color: Colors.white,
                              padding: EdgeInsets.all(10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                      radius: 30,
                                      /*ScreenUtil().setHeight(30)*/
                                      backgroundImage: response
                                                      .data![0].userData !=
                                                  null &&
                                              response.data![0].userData!
                                                      .profilePic !=
                                                  null
                                          ? NetworkImage(
                                                  '${response.data![0].userData!.profilePic}')
                                          : const AssetImage(
                                                  'assets/img/defaultprofile.jpg')
                                              as ImageProvider<Object>),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        response.data![0].userData != null &&
                                                response.data![0].userData!
                                                        .firstName !=
                                                    null
                                            ? '${response.data![0].userData!.firstName!} '
                                            : '',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          // fontFamily: 'Montserrat-Bold'
                                        ),
                                      ),
                                      FutureBuilder(
                                        future: HttpClient().getUserReviews(response.data![0].userData!.id.toString()),
                                        builder: (context, AsyncSnapshot<List<Rating>> ratings) {
                                          if (ratings.connectionState != ConnectionState.done) {
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
                                          } else if (ratings.hasError) {
                                            return const Center(child: Text('Something went wrong'));
                                          } else if (ratings.data != null) {
                                            List<double> reviewList = [];

                                            for (var element in ratings.data!) {
                                              if (element.rating != null) {
                                                reviewList.add(double.parse(element.rating!));
                                              }
                                            }

                                            return Row(
                                              children: [
                                                RatingBar.builder(
                                                  initialRating: getAverageRating(reviewList),
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemSize: 12,
                                                  ignoreGestures: true,
                                                  itemPadding: EdgeInsets.only(right: 0.1),
                                                  itemBuilder: (context, _) => const Icon(
                                                    Icons.star,
                                                    color: AppColors.app_yellow,
                                                  ),
                                                  onRatingUpdate: (rating) {
                                                    print(rating);
                                                  },
                                                ),
                                                Text(
                                                  getAverageRating(reviewList).toString(),
                                                  style: TextStyle(
                                                    fontSize: 10.sp,
                                                    color: AppColors.app_yellow,
                                                    // fontFamily: "Montserrat-bold"
                                                  ),
                                                ),
                                                Text(
                                                  ' (${reviewList.length} Rating)',
                                                  style: TextStyle(
                                                    fontSize: 10.sp,
                                                    color: AppColors.text_desc,
                                                    // fontFamily: "Montserrat-regular"
                                                  ),
                                                ),
                                              ],
                                            );
                                          } else {
                                            // Handle the case where ratings.data is null
                                            return const Center(child: Text('No reviews available'));
                                          }
                                        },
                                      )

                                    ],
                                  ))
                                ],
                              ),
                            ),
                            //---------------------------------------------------------//

                            5.verticalSpace,
                            Container(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  response.data![0].title!,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    // fontFamily: 'Montserrat-Bold'
                                  ),
                                )),
                            Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                                child: Text(
                                  response.data![0].description!,
                                  maxLines: 4,
                                  style: TextStyle(
                                    color: AppColors.text_desc,
                                    fontSize: 13,
                                    // fontFamily: 'Montserrat-Regular'
                                  ),
                                )),
                            Container(
                                padding: EdgeInsets.all(20),
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'Location',
                                          style: TextStyle(
                                            color: AppColors.text_desc,
                                            fontSize: 8,
                                            // fontFamily: 'Montserrat-Regular'
                                          ),
                                        ),
                                         Text(
                                          response.data![0].userData!.address !=
                                                  null
                                              ? response.data![0].userData!.address
                                              : 'Malta',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            // fontFamily: 'Montserrat-Regular'
                                          ),
                                        ),
                                      //   Text(
                                      //    ' response.data![0].userData!
                                      //                 '
                                      //     ,
                                      //     style: TextStyle(
                                      //       color: Colors.black,
                                      //       fontSize: 12,
                                      //       // fontFamily: 'Montserrat-SemiBold'
                                      //     ),
                                        // )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'Member Since',
                                          style: TextStyle(
                                            color: AppColors.text_desc,
                                            fontSize: 8,
                                            // fontFamily: 'Montserrat-Regular'
                                          ),
                                        ),
                                        Text(
                                          //  response.data![0].userData != null &&
                                          //       response.data![0].userData!
                                          //           .dateJoined !=
                                          //           null
                                          //       ? '${response.data![0].userData!.dateJoined!} '
                                          //       : '',
                                          response.data![0].userData!
                                                      .dateJoined !=
                                                  null
                                              ? DateFormat.yMMM()
                                                  .format(DateTime.parse(
                                                      response
                                                          .data![0]
                                                          .userData!
                                                          .dateJoined!))
                                                  .toString()
                                              : 'N/A',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            // fontFamily: 'Montserrat-SemiBold'
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'Avg. Response Time 1 hour',
                                          style: TextStyle(
                                            color: AppColors.text_desc,
                                            fontSize: 8,
                                            // fontFamily: 'Montserrat-Regular'
                                          ),
                                        ),
                                        Text(
                                          "1 hour",
                                          // response.data![0].servicepackages!=null ? response.data![0].servicepackages!.location ?? "" : "",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            // fontFamily: 'Montserrat-SemiBold'
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                )),
                            Container(
                                padding: EdgeInsets.all(15),
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text(
                                    //   'desc',
                                    //   style: TextStyle(
                                    //       color: Colors.grey,
                                    //       fontSize: 14,
                                    //       fontWeight: FontWeight.normal),
                                    // ),
                                    // SizedBox(
                                    //   height: 15,
                                    // ),

                                    Container(
                                      height: h * 0.06,
                                      width: w,
                                      // color: Colors.red,
                                      padding: EdgeInsets.only(top: 15),

                                      child: const Text(
                                        "GiG Overview",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          // fontFamily: 'Montserrat-Bold'
                                        ),
                                      ),

                                      // child: Row(
                                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      //   children: [
                                      //     Container(
                                      //       child: Column(
                                      //         children: [
                                      //           GestureDetector(
                                      //             onTap: (){
                                      //               basicOrAdvance = false;
                                      //               setState(() {

                                      //               });
                                      //             },
                                      //             child: Container(
                                      //                 height: h * 0.055,
                                      //                 width: w * 0.4,
                                      //                 child: Center(
                                      //                   child: Text(
                                      //                     "Basic",

                                      //                     style: TextStyle(
                                      //                         color: Colors.black,
                                      //                         fontSize: 14,
                                      //                         fontFamily:
                                      //                             'Montserrat-SemiBold'),
                                      //                   ),
                                      //                 )
                                      //                 // color: Colors.blue,
                                      //                 ),
                                      //           ),
                                      //           Expanded(
                                      //               child: Container(
                                      //                 // height: h * 0.04,
                                      //               width: w * 0.42,
                                      //             color: basicOrAdvance == false ? AppColors.app_color : Colors.white,
                                      //           ))
                                      //         ],
                                      //       ),
                                      //     ),
                                      //     Container(
                                      //       child: Column(
                                      //         children: [
                                      //           GestureDetector(
                                      //             onTap: (){
                                      //               basicOrAdvance = true;
                                      //               setState(() {

                                      //               });
                                      //             },
                                      //             child: Container(
                                      //                 height: h * 0.055,
                                      //                 width: w * 0.4,
                                      //                 child: Center(
                                      //                   child: Text(
                                      //                     "Advance",

                                      //                     style: TextStyle(
                                      //                         color: Colors.black,
                                      //                         fontSize: 14,
                                      //                         fontFamily:
                                      //                             'Montserrat-SemiBold'),
                                      //                   ),
                                      //                 )
                                      //                 // color: Colors.blue,
                                      //                 ),
                                      //           ),
                                      //           Expanded(
                                      //               child: Container(
                                      //                 // height: h * 0.04,
                                      //               width: w * 0.42,
                                      //             color: basicOrAdvance == true ?AppColors.app_color : Colors.white,
                                      //           ))
                                      //         ],
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(bottom: 10, top: 15),
                                      width: w * 0.8,
                                      // color: Colors.red,
                                      child: Text(
                                          response.data![0].servicepackages !=
                                                  null
                                              ? '\€ ${response.data![0].description!}'
                                              : '',
                                          style: TextStyle(
                                            color: AppColors.text_desc,
                                            fontSize: 10,
                                            // fontFamily: "Montserrat-Bold"
                                          )),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Text('Hourly Price',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                  // fontFamily:
                                                  // "Montserrat-Bold"
                                                ))),
                                        Text(
                                            response.data![0].servicepackages !=
                                                    null
                                                ? '\€ ${response.data![0].servicepackages!.price!}'
                                                : '',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              // fontFamily: "Montserrat-Bold"
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 18,
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().screenHeight * 0.05,
                                      child: TextButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  AppColors.app_color),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        ScreenUtil()
                                                                .screenHeight *
                                                            0.035)),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Opacity(
                                              opacity: 0,
                                              child:
                                                  Icon(Icons.arrow_forward_ios),
                                            ),
                                            Text(
                                              "Continue",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                fontSize: 12.sp,
                                                // fontFamily: 'Montserrat-Medium',
                                              ),
                                            ),
                                            Image.asset('assets/icons/arw.png',
                                                scale: 1.0),
                                          ],
                                        ),
                                        onPressed: () async {
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          String? address = prefs
                                              .getString('currentLocation');
                                          String? lat = prefs.getString('lat');
                                          String? long =
                                              prefs.getString('long');

                                          print('printing longitude ${long}');
                                          print('printing lattitude ${lat}');
                                          print(
                                              'printing lattitude ${address}');

                                          Map<String, dynamic> map = {
                                            'name': response.data![0].title,
                                            'desc':
                                                response.data![0].description,
                                            'price': response.data![0]
                                                .servicepackages!.price,
                                            //'image': response.data![0].gigdocument![0].fileName ?? "",
                                            'location': response.data![0]
                                                .servicepackages!.location,
                                            'provider_id':
                                                response.data![0].userId,
                                            'service_id': response.data![0].id,
                                          };

                                          //  Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             OrderReview(
                                          //               bodyprovider: map,
                                          //             )));

                                          if (StorageManager()
                                              .accessToken
                                              .isNotEmpty) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        OrderReview(
                                                            bodyprovider: map,
                                                            long: long ??
                                                                '14.3754',
                                                            address: address ??
                                                                'Malta',
                                                            lat: lat ??
                                                                '35.9375',
                                                            userId: response
                                                                .data![0]
                                                                .userId!
                                                                .toString(),
                                                            categoryId: response
                                                                .data![0]
                                                                .categoryId!
                                                                .toString())));
                                          } else {
                                            // showLoginDialog(context, "Please login to continue");
                                            bottomSheetForSignIn(context, map,
                                                userId: response
                                                    .data![0].userId!
                                                    .toString(),
                                                categoryId: response
                                                    .data![0].categoryId!
                                                    .toString());
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                )),

                            // FutureBuilder(
                            //   future: HttpClient().getUserReviews(
                            //       response.data![0].userData!.id.toString()),
                            //   builder: (context,
                            //       AsyncSnapshot<List<Rating>> ratings) {
                            //     if (ratings.connectionState !=
                            //         ConnectionState.done) {
                            //       return const Center(
                            //           child: Padding(
                            //         padding: EdgeInsets.all(15.0),
                            //         child: SizedBox(
                            //             height: 20,
                            //             width: 20,
                            //             child: CircularProgressIndicator(
                            //               color: Colors.blue,
                            //             )),
                            //       ));
                            //     }
                            //     List<double> reviewList = [];
                            //
                            //     for (var element in ratings.data!) {
                            //       reviewList.add(double.parse(element.rating!));
                            //     }
                            //
                            //     return Container(
                            //       width: MediaQuery.of(context).size.width,
                            //       child: Column(
                            //         children: [
                            //           Container(
                            //             padding: EdgeInsets.all(20),
                            //             child: Row(
                            //               children: [
                            //                 RatingBar.builder(
                            //                   initialRating:
                            //                       getAverageRating(reviewList),
                            //                   minRating: 1,
                            //                   direction: Axis.horizontal,
                            //                   allowHalfRating: true,
                            //                   itemCount: 5,
                            //                   itemSize: 12,
                            //                   ignoreGestures: true,
                            //                   itemPadding:
                            //                       EdgeInsets.only(right: 0.1),
                            //                   itemBuilder: (context, _) => Icon(
                            //                       Icons.star,
                            //                       color: AppColors.app_yellow),
                            //                   onRatingUpdate: (rating) {
                            //                     print(rating);
                            //                   },
                            //                 ),
                            //                 Text(
                            //                   getAverageRating(reviewList)
                            //                       .toString(),
                            //                   style: TextStyle(
                            //                     fontSize: 10.sp,
                            //                     color: AppColors.app_yellow,
                            //                     // fontFamily: "Montserrat-bold"
                            //                   ),
                            //                 ),
                            //                 Text(
                            //                   ' (${reviewList.length} Rating)',
                            //                   style: TextStyle(
                            //                     fontSize: 10.sp,
                            //                     color: AppColors.text_desc,
                            //                     // fontFamily: "Montserrat-regular"
                            //                   ),
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //           Container(
                            //             padding: const EdgeInsets.only(
                            //                 bottom: 20, left: 20, right: 20),
                            //             margin: const EdgeInsets.only(
                            //                 left: 20, right: 20),
                            //             decoration: BoxDecoration(
                            //               color: Color(0xff4995EB)
                            //                   .withOpacity(0.2),
                            //               borderRadius:
                            //                   BorderRadius.circular(10),
                            //             ),
                            //             child: Column(
                            //               children: [
                            //                 ListView.builder(
                            //                   shrinkWrap: true,
                            //                   physics:
                            //                       NeverScrollableScrollPhysics(),
                            //                   itemCount:
                            //                       5, // Assuming 5 star ratings
                            //                   itemBuilder: (context, index) {
                            //                     int starRating = index + 1;
                            //                     double ratingPercentage = 0;
                            //
                            //                     if (ratings.data!.length > 0) {
                            //                       ratingPercentage =
                            //                           getRatingPercentageForRating(
                            //                               starRating,
                            //                               ratings.data!);
                            //                       print(
                            //                           'printing rating perc ${ratingPercentage}');
                            //                     }
                            //
                            //                     else {
                            //                       ratingPercentage = 0;
                            //                     }
                            //                     int reviewCount = ratings.data!
                            //                         .where((rating) =>
                            //                             rating.rating ==
                            //                             starRating.toString())
                            //                         .length;
                            //                     String starText =
                            //                         '${starRating} Stars';
                            //
                            //                     return Column(
                            //                       mainAxisAlignment:
                            //                           MainAxisAlignment.start,
                            //                       children: [
                            //                         Row(
                            //                           children: [
                            //                             Expanded(
                            //                               child: Text(
                            //                                 starText,
                            //                                 style: TextStyle(
                            //                                   color:
                            //                                       Colors.black,
                            //                                   fontSize: 14,
                            //                                   // fontFamily: 'Montserrat-Bold',
                            //                                 ),
                            //                               ),
                            //                             ),
                            //                             Text(
                            //                               '$reviewCount Reviews',
                            //                               style: TextStyle(
                            //                                 color: AppColors
                            //                                     .text_desc,
                            //                                 fontSize: 10,
                            //                                 // fontFamily: 'Montserrat-Regular',
                            //                               ),
                            //                             ),
                            //                           ],
                            //                         ),
                            //                         SizedBox(height: 2),
                            //                         LinearProgressIndicator(
                            //                           backgroundColor:
                            //                               Colors.white,
                            //                           valueColor:
                            //                               AlwaysStoppedAnimation<
                            //                                       Color>(
                            //                                   AppColors
                            //                                       .app_color),
                            //                           value: ratingPercentage ==
                            //                                   null
                            //                               ? 0
                            //                               : ratingPercentage,
                            //                         ),
                            //                         SizedBox(height: 5),
                            //                       ],
                            //                     );
                            //                   },
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //           Container(
                            //             width: double.infinity,
                            //             padding: EdgeInsets.only(
                            //                 left: 20,
                            //                 right: 20,
                            //                 bottom: 5,
                            //                 top: 10),
                            //             child: Text(
                            //               " ${reviewList.length} Reviews",
                            //               style: TextStyle(
                            //                   color: Color(0xffF79E1F),
                            //                   fontSize: 14,
                            //                   fontWeight: FontWeight.bold),
                            //             ),
                            //           ),
                            //           ratings.data!.length > 0
                            //               ? Container(
                            //                   width: double.infinity,
                            //                   padding: const EdgeInsets.only(
                            //                       left: 20,
                            //                       right: 20,
                            //                       top: 0,
                            //                       bottom: 0),
                            //                   height: 145,
                            //                   child: SizedBox(
                            //                       height: 100,
                            //                       width: 250,
                            //                       child: ListView.builder(
                            //                         padding: EdgeInsets.zero,
                            //                         shrinkWrap: true,
                            //                         scrollDirection:
                            //                             Axis.horizontal,
                            //                         itemCount:
                            //                             ratings.data!.length,
                            //                         itemBuilder:
                            //                             (context, index) {
                            //                           return ReviewItem(
                            //                               rating: ratings
                            //                                   .data![index]);
                            //                         },
                            //                       )),
                            //                 )
                            //               : SizedBox(
                            //                   height: 30,
                            //                 ),
                            //         ],
                            //       ),
                            //     );
                            //   },
                            // ),

                            Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: const Text(
                                'Recommended for you',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),

                            FutureBuilder<List<DataModel>>(
                              future: fetchDataList(
                                  userId: response.data![0].userId!,
                                  categoryId: response.data![0].categoryId!),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<DataModel>> snapshot) {
                                print(
                                    'pritning mydata ${snapshot.data.toString()}');

                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: CircularProgressIndicator()));
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  if (snapshot.hasData &&
                                      snapshot.data!.length > 0) {
                                    // Process the data here
                                    final data = snapshot.data!;
                                    print('pritning mydata ${data.toString()}');
                                    return Container(
                                      padding: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 0,
                                          bottom: 0),
                                      height: 250,
                                      child: SizedBox(
                                          height: 200,
                                          child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: snapshot.data?.length,
                                            itemBuilder: (context, index) {
                                              final item = data[index];

                                              return InkWell(
                                                  onTap: () async {
                                                    SharedPreferences prefs =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    String? addres =
                                                        prefs.getString(
                                                            'currentLocation');
                                                    Navigator.of(context)
                                                        .pushReplacement(
                                                            MaterialPageRoute(
                                                      builder: (context) {
                                                        return ProviderDetailScreen(
                                                          id: snapshot

                                                              .data![index].id!.toInt(),
                                                          location:
                                                              addres ?? 'Malta',
                                                        );
                                                      },
                                                    ));
                                                  },
                                                  child: RecommendedItem(
                                                      item: item));
                                            },
                                          )),
                                    );
                                  } else {
                                    return Container(
                                        child: Column(
                                      children: [
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Text(
                                          'No Similar Products available',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                      ],
                                    ));
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 20, top: 50),
                            child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 15,
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back_ios_new,
                                      color: Colors.black,
                                      size: 15,
                                    ),
                                  ),
                                ))),
                      ],
                    ),
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text('No Data Found..!'),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      FloatingActionButton.extended(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        label: Text('Back to Homepage'),
                        icon: Icon(Icons.arrow_back),
                      )
                    ],
                  );
                }
              }
            }));
  }

  Widget getDataImage(List<Gigdocument> item) {
    if (item.isNotEmpty) {
      print(item[0].fileName);
      return Image.network(
          "https://urbanmalta.com/public/users/user_${item[0].userid}/documents/${item[0].fileName}",
          height: double.infinity,
          width: 150,
          fit: BoxFit.fill);
    } else {
      return Image.asset('assets/images/barber.jpg',
          height: 120, width: 150, fit: BoxFit.fill);
    }
  }

  // showLoginDialog(context, String message) {
  //
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return WarningDialogBox(
  //           title: 'Alert',
  //           descriptions: message,
  //           buttonTitle:'ok',
  //           buttonColor: AppColors.color_green,
  //           icon: Icons.cancel,
  //           onPressed: () {
  //             Navigator.pop(context);
  //             SchedulerBinding.instance.addPostFrameCallback((_) async {
  //               final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(isFromOtherScreen: true)));
  //               if(result=="1"){
  //
  //               }
  //
  //             });
  //           },
  //         );
  //       });
  // }

  bottomSheetForSignIn(BuildContext context, Map<String, dynamic> map,
      {String? userId, String? categoryId}) {
    showModalBottomSheet(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height - 50),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: LoginScreen(isFromOtherScreen: true));
        }).whenComplete(() {
      print('ondismiss');
      if (StorageManager().accessToken.isNotNullAndNotEmpty) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderReview(
                      bodyprovider: map,
                      userId: userId,
                      categoryId: categoryId,
                    )));
      }
    });
  }
}
