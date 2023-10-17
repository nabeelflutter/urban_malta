import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/models/recommended.dart';
import 'package:kappu/models/serializable_model/provider_detail_model.dart';

import '../../models/serializable_model/review.dart';
import '../../net/http_client.dart';

class RecommendedItem extends StatelessWidget {
  const RecommendedItem({Key? key, required this.item}) : super(key: key);
  final DataModel item;
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 150,
      margin: EdgeInsets.only(right: 10, bottom: 10, top: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                image: DecorationImage(
                    image: AssetImage('assets/images/tt.png' ) ,fit: BoxFit.fill)),
          ),
          SizedBox(height: 5,),
          Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            child:  Text(
              item.servicePackage!.title,
              style: TextStyle(
                  color: AppColors.app_color,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 5,),
          Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            child:  Text(
              item.servicePackage!.description,
              maxLines: 3,
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.normal),
            ),
          ),
          SizedBox(
            height: 5,
          ),

          // FutureBuilder(future: HttpClient().getUserReviews(item.userData!.id.toString()),builder: (context, AsyncSnapshot<List<Rating>> ratings) {
          //   if (ratings.connectionState != ConnectionState.done) {
          //     return const Center(child: Padding(
          //       padding: EdgeInsets.all(15.0),
          //       child: SizedBox(height: 20,width: 20,child: CircularProgressIndicator(color: Colors.blue,)),
          //     ));
          //   }
          //   List<double> reviewList=[];
          //
          //   for (var element in ratings.data!) {
          //     reviewList.add(double.parse(element.rating!));
          //   }
          //
          //   return   Row(
          //     children: [
          //       RatingBar.builder(
          //         initialRating: getAverageRating(reviewList),
          //         minRating: 1,
          //         direction: Axis.horizontal,
          //         allowHalfRating: true,
          //         itemCount: 5,
          //         itemSize: 12,
          //         ignoreGestures: true,
          //         itemPadding:
          //         EdgeInsets.only(right: 0.1),
          //         itemBuilder: (context, _) => Icon(
          //             Icons.star,
          //             color: AppColors.app_yellow),
          //         onRatingUpdate: (rating) {
          //           print(rating);
          //         },
          //       ),
          //       SizedBox(width: 10,),
          //       Text(
          //         getAverageRating(reviewList).toString(),
          //         style: TextStyle(
          //             fontSize: 10.sp,
          //             color: AppColors.app_yellow,
          //             // fontFamily: "Montserrat-bold"
          //             ),
          //       ),
          //
          //     ],
          //   );
          // },),








          SizedBox(height: 5,),
          Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Row(
              children: [
                Expanded(
                    child: Text('Hourly Price',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight:
                            FontWeight.bold))),
                Text(
                    '\€ ${ item.servicePackage!.price}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
