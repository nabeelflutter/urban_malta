import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/common/button.dart';
import 'package:kappu/common/painter.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/components/MyAppBar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kappu/constants/storage_manager.dart';
import 'package:kappu/main.dart';
import 'package:kappu/models/serializable_model/OrderListResponse.dart';
import 'package:kappu/models/serializable_model/booking.dart';
import 'package:kappu/screens/add_review/review_submitted.dart';

import '../../net/base_dio.dart';
import '../../net/http_client.dart';
import '../register/widgets/text_field.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

// const String testDevice = "787b9e0b-4f7c-47eb-a0b8-0eb9a7554728";

class AddReview extends ModalRoute<void> {
  final OrderListResponse booking;
  final Function setbookingstate;

  AddReview({
    required this.booking,
    required this.setbookingstate,
  });

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
  TextEditingController amountController = TextEditingController();

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

  TextEditingController ratingcontoller = TextEditingController();
  bool publishingfeedback = false;

  double rating = 2.0;
  final formkey = GlobalKey<FormState>();

  Widget _buildOverlayContent(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Storage Manager",
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              ),
        ),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back_ios_new,color: AppColors.iconColor,))
        // const BackButton(
        //   color: AppColors.iconColor,
        // ),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Form(
            key: formkey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                child: Text(
                  'Rate your experience',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(22)),
                ),
              ),
              10.verticalSpace,
              Text(
                'How was Your experience With ${booking.userData!.firstName}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.title_desc,
                    fontSize: ScreenUtil().setSp(14)),
              ),
              20.verticalSpace,
              RatingBar.builder(
                initialRating: 0,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                unratedColor: Colors.grey,
                itemCount: 5,
                itemSize: 40.0,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (ratingvalue) {
                  setState(() {
                    rating = ratingvalue;
                  });
                },
                updateOnDrag: true,
              ),
              30.verticalSpace,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextFormField(
                  controller: ratingcontoller,
                  hintText: 'Share your experience',
                  keyboardType: TextInputType.text,
                  validator: (value) =>
                      value!.isEmpty ? "Enter your experience" : null,
                  maxlines: 10,
                  bordercolor: Colors.grey,
                ),
              ),
              10.verticalSpace,
              Text(
                '  Please include at least 10 characters.',
                style: TextStyle(
                    color: Colors.black, fontSize: ScreenUtil().setSp(14)),
              ),
              20.verticalSpace,
              SizedBox(
                height: ScreenUtil().screenHeight * 0.05,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.app_color),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              ScreenUtil().screenHeight * 0.025)),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Opacity(
                        opacity: 0,
                        child: Icon(Icons.arrow_forward_ios),
                      ),
                      Text(
                        "Submit a Review",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontFamily: 'Montserrat-Medium',
                        ),
                      ),
                      Image.asset('assets/icons/arw.png', scale: 1.0),
                    ],
                  ),
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      publishingfeedback = true;
                      changedExternalState();

                      Map<String, dynamic> body = {
                        "rating": rating,
                        "review": ratingcontoller.text,
                        "reviewer_id": StorageManager().userId,
                        //  "service": booking.serviceId.toString(),
                        "order_id": booking.id,
                      };

                      await HttpClient()
                          .addreview(body, StorageManager().accessToken)
                          .then((reviewresponse) {
                        publishingfeedback = true;

                        changedExternalState();
                        // Navigator.pop(context);
                        // Navigation to a new screen after the API call is successful
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReviewSubmitted(), // Replace 'NewScreen' with the desired screen you want to navigate to.
                          ),
                        );

                        // ratingSubmitThanks.png
                        setbookingstate();
                      }).catchError((error) {
                        changedExternalState();
                        Navigator.pop(context);
                        BaseDio.getDioError(error);
                      });
                    }
                  },
                ),
              ),
              20.verticalSpace,
              // Container(
              //     color: AppColors.app_bg,
              //     child:  DecoratedBox(
              //       decoration: BoxDecoration(
              //           borderRadius: const BorderRadius.all(Radius.circular(6)),
              //           color: AppColors.app_bg),
              //       child: Padding(
              //         padding: EdgeInsets.all(10),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text(
              //               'Awesome Sellers deserve a tip',
              //               style: TextStyle(
              //                   color: Colors.black,
              //                   fontWeight: FontWeight.bold,
              //                   fontSize: ScreenUtil().setSp(18)),
              //             ),
              //             10.verticalSpace,
              //             Text(
              //               'It\'s customary to leave a tip for the seller\'s service.',
              //               textAlign: TextAlign.center,
              //               style: TextStyle(
              //                   color: AppColors.title_desc,
              //                   fontSize: ScreenUtil().setSp(12)),
              //             ),
              //             10.verticalSpace,
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Card(
              //                   color: Colors.white,
              //                   child: Padding(
              //                     padding: const EdgeInsets.all(20),
              //                     child: Column(
              //                       crossAxisAlignment: CrossAxisAlignment.center,
              //                       children: const [
              //
              //                         Text(
              //                           "15%",
              //                           textAlign: TextAlign.center,
              //                           style: TextStyle(
              //                             color: Colors.black,
              //                             fontSize: 16,
              //                             fontFamily: 'Montserrat-Bold',
              //                           ),
              //                         )
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //                 Card(
              //                   color: Colors.white,
              //                   child: Padding(
              //                     padding: const EdgeInsets.all(20),
              //                     child: Column(
              //                       crossAxisAlignment: CrossAxisAlignment.center,
              //                       children: const [
              //
              //                         Text(
              //                           "20%",
              //                           textAlign: TextAlign.center,
              //                           style: TextStyle(
              //                             color: Colors.black,
              //                             fontSize: 16,
              //                             fontFamily: 'Montserrat-Bold',
              //                           ),
              //                         )
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //                 Card(
              //                   color: Colors.white,
              //                   child: Padding(
              //                     padding: const EdgeInsets.all(20),
              //                     child: Column(
              //                       crossAxisAlignment: CrossAxisAlignment.center,
              //                       children: const [
              //
              //                         FittedBox(
              //                           fit: BoxFit.contain,
              //                           child: Text(
              //                             '25%',
              //                             textAlign: TextAlign.justify,
              //                             style: TextStyle(
              //                               color: Colors.black,
              //                               fontSize: 16,
              //                               fontFamily: 'Montserrat-Bold',
              //                             ),
              //                           ),
              //                         )
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             10.verticalSpace,
              //             ElevatedTextFormField(
              //               controller: amountController,
              //               keyboardType: TextInputType.text,
              //               hintText: 'Enter Custom Amount',
              //               onChanged: (value) {
              //                 setState(() {});
              //               },
              //             ),
              //             10.verticalSpace,
              //             SizedBox(
              //               height: ScreenUtil().screenHeight * 0.05,
              //               child: TextButton(
              //                 style: ButtonStyle(
              //                   backgroundColor: MaterialStateProperty.all(AppColors.app_color),
              //                   shape: MaterialStateProperty.all(
              //                     RoundedRectangleBorder(
              //                         borderRadius: BorderRadius.circular(
              //                             ScreenUtil().screenHeight * 0.025)),
              //                   ),
              //                 ),
              //                 child: Row(
              //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                   children: [
              //                     const Opacity(
              //                       opacity: 0,
              //                       child: Icon(Icons.arrow_forward_ios),
              //                     ),
              //                     Text(
              //                       "Submit",
              //                       style: TextStyle(
              //                         fontWeight: FontWeight.w500,
              //                         color: Colors.white,
              //                         fontSize: 14.sp,
              //                         fontFamily: 'Montserrat-Medium',
              //                       ),
              //                     ),
              //                     Image.asset('assets/icons/arw.png', scale: 1.0),
              //                   ],
              //                 ),
              //                 onPressed: () {
              //                 },
              //               ),
              //             ),
              //             15.verticalSpace,
              //
              //
              //           ],
              //         ),
              //       ),
              //     )
              // ),
              // 20.verticalSpace
            ]),
          ),
        ),
      ),
    );
  }
}
