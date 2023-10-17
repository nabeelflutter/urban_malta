import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/models/serializable_model/booking.dart';

import '../../../models/serializable_model/OrderListResponse.dart';

class BookingRatingWidget extends StatelessWidget {
  final OrderListResponse booking;
  const BookingRatingWidget({Key? key, required this.booking})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(15), left: 8),
      child: Container(
        height: 105.h,
        width: 300.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade300)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                'Your Rating',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil().setSp(14)),
              ),
              Container(
                height: ScreenUtil().setHeight(25),
                width: ScreenUtil().setWidth(60),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade300)),
                child: Center(
                  child: Text(
                    booking.rating.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(14)),
                  ),
                ),
              )
            ]),
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(5)),
              child: RatingBarIndicator(
                rating: double.parse(booking.rating!),
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
