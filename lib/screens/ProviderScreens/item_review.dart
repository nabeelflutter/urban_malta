import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:kappu/models/serializable_model/provider_detail_model.dart';

import '../../components/AppColors.dart';
import '../../models/serializable_model/review.dart';

class ReviewItem extends StatelessWidget {
  ReviewItem({
    Key? key,
    this.rating,
  }) : super(key: key);
  Rating? rating;
  int getDaysDifference(String dateString) {
    DateTime date = DateFormat("yyyy-MM-dd HH:mm:ss.SSSZ").parse(dateString);
    DateTime now = DateTime.now();

    int difference = now.difference(date).inDays;

    return difference;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                width: 300,
                child: Card(
                    child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: ScreenUtil().setHeight(15),
                            backgroundImage: rating
                                        ?.servicereviews?.profilePic ==
                                    null
                                ? NetworkImage(
                                    'https://urbanmalta.com/public/frontend/images/johnwing-app.png')
                                : NetworkImage(
                                    "https://urbanmalta.com/public/users/user_${rating?.reviewerId}/documents/${rating?.servicereviews?.profilePic}",
                                  ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '${rating?.servicereviews!.firstName} ${rating?.servicereviews!.lastName}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.pin_drop,
                                    color: AppColors.app_color,
                                    size: 15,
                                  ),
                                  Text(
                                    '${rating?.servicereviews!.location}',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Row(
                        children: [
                          RatingBar.builder(
                            initialRating: double.parse(rating!.rating!),
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 13,
                            ignoreGestures: true,
                            itemPadding: EdgeInsets.only(right: 0.1),
                            itemBuilder: (context, _) =>
                                Icon(Icons.star, color: Colors.amber),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                          Text(
                            rating!.rating!,
                            style: TextStyle(
                              color: Color(0xffF79E1F),
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.01,
                          ),
                          Text(
                            "Published ${getDaysDifference(rating!.createdAt!.toString()).toString()} Days ago",
                            style: TextStyle(
                              color: AppColors.text_desc,
                              fontSize: 8,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Text(
                        '${rating?.review}',
                        maxLines: 3,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ))),
            SizedBox(
              width: 10,
            )
          ],
        ),
      ],
    );
  }
}
