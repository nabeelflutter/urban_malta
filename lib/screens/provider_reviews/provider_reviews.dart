import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/components/MyAppBar.dart';
import 'package:kappu/constants/storage_manager.dart';
import 'package:kappu/models/serializable_model/review.dart';
import 'package:kappu/screens/ProviderScreens/item_review.dart';

import '../../models/serializable_model/provider_detail_model.dart';
import '../../net/http_client.dart';

class ProviderReviewsPage extends StatefulWidget {
  final int providerid;
  final double averagerating;

  const ProviderReviewsPage(
      {Key? key, required this.providerid, required this.averagerating})
      : super(key: key);

  @override
  _ProviderReviewsPageState createState() => _ProviderReviewsPageState();
}

class _ProviderReviewsPageState extends State<ProviderReviewsPage> {
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

  int getDaysDifference(String dateString) {
    DateTime date = DateFormat("yyyy-MM-dd HH:mm:ss.SSSZ").parse(dateString);
    DateTime now = DateTime.now();

    int difference = now.difference(date).inDays;

    return difference;
  }

  double getRatingPercentageForRating(int starRating, List<Rating> ratings) {
    // Calculate the count of reviews for the given star rating
    int reviewCount = ratings
        .where((rating) => rating.rating == starRating.toString())
        .length;

    // Calculate the total count of reviews
    int totalCount = ratings.length;

    // Handle edge case where totalCount is 0 to avoid division by zero
    if (totalCount == 0) {
      return 0.0;
    }

    // Calculate the rating percentage for the given star rating
    double ratingPercentage = reviewCount / totalCount;

    return ratingPercentage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color_f2f7fd,
      // appBar: MyAppBar(
      //   title: "Total Ratings and Reviews",
      // ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Total Ratings and Reviews",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back_ios_new,color: AppColors.iconColor,))
      ),

      body: FutureBuilder(
        future: HttpClient().getUserReviews(StorageManager().userId.toString()),
        builder: (context, AsyncSnapshot<List<Rating>> ratings) {
          if (ratings.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          List<double> reviewList = [];

          // Check if there are no reviews
          if (ratings.data == null || ratings.data!.isEmpty) {
            return SizedBox(
              height: ScreenUtil().setHeight(590),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/noCustomerrating.png', // Replace with your image path
                            width: MediaQuery.of(context).size.width *
                                0.7, // Set the width of the image
                            height: 200, // Set the height of the image
                            fit: BoxFit
                                .contain, // Set the fit of the image inside the container
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            'No Ratings and Reviews Yet',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromRGBO(22, 29, 53, 1),
                              // fontFamily: 'Merriweather',
                              fontSize: 20,
                              letterSpacing: 0,
                              fontWeight: FontWeight.bold,
                              height: 1,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            "Don't worry! As you deliver great service, this space will ",
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
                          SizedBox(height: 4.0),
                          Text(
                            'soon fill up with glowing reviews and top ratings. Your',
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
                          SizedBox(height: 4.0),
                          Text(
                            'journey to success begins now.',
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          // noCustomerrating.png
          for (var element in ratings.data!) {
            reviewList.add(double.parse(element.rating!));
          }
          return ListView(
            shrinkWrap: true,
            children: [
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Reviews as Seller",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            // fontFamily: "Montserrat-Bold"
                            ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RatingBar.builder(
                            initialRating: getAverageRating(reviewList),
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 20,
                            itemPadding: EdgeInsets.only(right: 2),
                            itemBuilder: (context, _) =>
                                Icon(Icons.star, color: Colors.amber),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                          Text('3')
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(
                        height: 1,
                        color: AppColors.shadow,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          color: Color(0xff4995EB).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: 5, // Assuming 5 star ratings
                              itemBuilder: (context, index) {
                                int starRating = index + 1;
                                double ratingPercentage =
                                    getRatingPercentageForRating(
                                        starRating, ratings.data!);
                                int reviewCount = ratings.data!
                                    .where((rating) =>
                                        rating.rating == starRating.toString())
                                    .length;
                                String starText = '${starRating} Stars';

                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            starText,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              // fontFamily: 'Montserrat-Bold',
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '$reviewCount Reviews',
                                          style: TextStyle(
                                            color: AppColors.text_desc,
                                            fontSize: 10,
                                            // fontFamily: 'Montserrat-Regular',
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 2),
                                    LinearProgressIndicator(
                                      backgroundColor: Colors.white,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          AppColors.app_color),
                                      value: ratingPercentage,
                                    ),
                                    SizedBox(height: 5),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(15)),
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: ScreenUtil().setHeight(12)),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: ratings.data!.length,
                    itemBuilder: (context, index) {
                      print(
                          'printing rating response ${ratings.data![index].createdAt!}');

                      return Padding(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: ScreenUtil().setHeight(15),
                              backgroundImage: ratings.data?[index]
                                          .servicereviews?.profilePic ==
                                      null
                                  ? NetworkImage(
                                      'https://urbanmalta.com/public/frontend/images/johnwing-app.png')
                                  : NetworkImage(
                                      "https://urbanmalta.com/public/users/user_${ratings.data![index].reviewerId}/documents/${ratings.data?[index].servicereviews?.profilePic}",
                                    ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    '${ratings.data![index].servicereviews!.firstName} ${ratings.data![index].servicereviews!.lastName}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${ratings.data![index].servicereviews!.location}',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          RatingBar.builder(
                                            initialRating: double.parse(
                                                ratings.data![index].rating!),
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemSize: 20,
                                            ignoreGestures: true,
                                            itemPadding:
                                                EdgeInsets.only(right: 0.1),
                                            itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: Colors.amber),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            '${ratings.data![index].rating!}',
                                            style: TextStyle(
                                              color: AppColors.app_yellow,
                                              // fontFamily: "Montserrat-Bold",
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '${getDaysDifference(ratings.data![index].createdAt!.toString()).toString()} Days ago',
                                        style: TextStyle(
                                          color: AppColors.text_desc,
                                          // fontFamily: "Montserrat-Medium",
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${ratings.data![index].review}',
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/*
class _ProviderReviewsPageState extends State<ProviderReviewsPage> {

  int getDaysDifference(String dateString) {
    DateTime date = DateFormat("yyyy-MM-dd HH:mm:ss.SSSZ").parse(dateString);
    DateTime now = DateTime.now();

    int difference = now.difference(date).inDays;

    return difference;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color_f2f7fd,
      appBar: MyAppBar(
        title: "Total Ratings and Reviews",
      ),
      body: FutureBuilder( future: HttpClient().getUserReviews(),builder: (context, AsyncSnapshot<List<Rating>> ratings) {
        if (ratings.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView(shrinkWrap: true, children: [
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Reviews as Seller",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontFamily: "Montserrat-Bold"),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RatingBar.builder(
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 20,
                        itemPadding: EdgeInsets.only(right: 2),
                        itemBuilder: (context, _) =>
                            Icon(Icons.star, color: Colors.amber),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      Text('3')
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    height: 1,
                    color: AppColors.shadow,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                          color: Color(0xff4995EB).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [


                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: ratings.data!.length,
                            itemBuilder: (context, index) {

                              List<double> reviewList=[];

                              for (var element in ratings.data!) {
                                reviewList.add(double.parse(element.rating!));
                              }

                              double? rating = reviewList[index];
                              double ratingPercentage = rating / 5.0;
                              int reviewCount = reviewList.length;
                              String starText = '${rating} Stars';

                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          starText,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'Montserrat-Bold',
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '$reviewCount Reviews',
                                        style: TextStyle(
                                          color: AppColors.text_desc,
                                          fontSize: 10,
                                          fontFamily: 'Montserrat-Regular',
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 2),
                                  LinearProgressIndicator(
                                    backgroundColor: Colors.white,
                                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.app_color),
                                    value: ratingPercentage,
                                  ),
                                  SizedBox(height: 5),
                                ],
                              );
                            },
                          ),




                        ],
                      )),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding:
              EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
              child: ListView.builder(

                padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(12),
                ),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: ratings.data!.length,
                itemBuilder: (context, index) {
                  print('printing rating response ${ratings.data![index].createdAt!}');

                  return Padding(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: ScreenUtil().setHeight(15),
                          backgroundImage: ratings.data?[index].servicereviews?.profilePic == null ?  NetworkImage(
                              'https://urbanmalta.com/public/frontend/images/johnwing-app.png') : NetworkImage(
                            "https://urbanmalta.com/public/users/user_${ratings.data![index].reviewerId}/documents/${ratings.data?[index].servicereviews?.profilePic}",),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '${ratings.data![index].servicereviews!.firstName} ${ratings.data![index].servicereviews!.lastName}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${ratings.data![index].servicereviews!.location}',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      //   mainAxisSize: MainAxisSize.min,
                                      children: [
                                        RatingBar.builder(
                                          initialRating: double.parse(ratings.data![index].rating!),
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 20,
                                          ignoreGestures: true,
                                          itemPadding: EdgeInsets.only(right: 0.1),
                                          itemBuilder: (context, _) =>
                                              Icon(Icons.star, color: Colors.amber),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                        SizedBox(width: 10,),
                                        Text(
                                          '${ratings.data![index].rating!}',
                                          style: TextStyle(
                                              color: AppColors.app_yellow,
                                              fontFamily: "Montserrat-Bold",
                                              fontSize: 10),
                                        ),


                                      ],
                                    ),
                                    Text(
                                      '${getDaysDifference(ratings.data![index].createdAt!.toString()).toString()} Daya ago',
                                      style: TextStyle(
                                          color: AppColors.text_desc,
                                          fontFamily: "Montserrat-Medium",
                                          fontSize: 10),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  '${ratings.data![index].review}',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                )
                              ],
                            ))
                      ],
                    ),
                  );
                },
              ),*/
/*FutureBuilder(
                future: HttpClient().getUserReviews(),
                builder: (context, AsyncSnapshot<List<Rating>> ratings) {
                  if (ratings.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(

                    padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(12),
                    ),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: ratings.data!.length,
                    itemBuilder: (context, index) {
                      print('printing rating response ${ratings.data![index].createdAt!}');

                      return Padding(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: ScreenUtil().setHeight(15),
                              backgroundImage: ratings.data?[index].servicereviews?.profilePic == null ?  NetworkImage(
                                  'https://urbanmalta.com/public/frontend/images/johnwing-app.png') : NetworkImage(
                                  "https://urbanmalta.com/public/users/user_${ratings.data![index].reviewerId}/documents/${ratings.data?[index].servicereviews?.profilePic}",),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '${ratings.data![index].servicereviews!.firstName} ${ratings.data![index].servicereviews!.lastName}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${ratings.data![index].servicereviews!.location}',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                               //   mainAxisSize: MainAxisSize.min,
                                      children: [
                                        RatingBar.builder(
                                          initialRating: double.parse(ratings.data![index].rating!),
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 20,
                                          ignoreGestures: true,
                                          itemPadding: EdgeInsets.only(right: 0.1),
                                          itemBuilder: (context, _) =>
                                              Icon(Icons.star, color: Colors.amber),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                        SizedBox(width: 10,),
                                        Text(
                                          '${ratings.data![index].rating!}',
                                          style: TextStyle(
                                              color: AppColors.app_yellow,
                                              fontFamily: "Montserrat-Bold",
                                              fontSize: 10),
                                        ),


                                      ],
                                    ),
                                    Text(
                                      '${getDaysDifference(ratings.data![index].createdAt!.toString()).toString()} Daya ago',
                                      style: TextStyle(
                                          color: AppColors.text_desc,
                                          fontFamily: "Montserrat-Medium",
                                          fontSize: 10),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  '${ratings.data![index].review}',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                )
                              ],
                            ))
                          ],
                        ),
                      );
                    },
                  );
                }),*//*

            ),
          )
        ]);
      },)
    );
  }
}
*/
