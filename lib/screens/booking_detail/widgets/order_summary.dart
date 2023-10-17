import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/models/serializable_model/booking.dart';

import '../../../common/customtexts.dart';

class OrderSmmary extends StatelessWidget {
  final String bookingstatus;
  final Booking booking;
  const OrderSmmary(
      {Key? key, required this.booking, required this.bookingstatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customtext(
              buttontext: booking.id.toString() + '12AS234',
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            Container(
              height: 28.h,
              width: 90.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: bookingstatus == "Active"
                      ? Colors.blue.shade50
                      : bookingstatus == "Cancelled"
                          ? Colors.red.shade50
                          : Colors.green.shade50),
              child: Center(
                child: Text(
                  bookingstatus,
                  style: TextStyle(
                      color: bookingstatus == "Active"
                          ? Colors.blue.shade700
                          : bookingstatus == "Cancelled"
                              ? Colors.red.shade700
                              : Colors.green.shade700,
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp),
                ),
              ),
            )
          ],
        ),
        15.verticalSpace,
        customtext(
          buttontext: booking.servicetitle,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        6.verticalSpace,
        customtext(
          buttontext: booking.time,
          color: Colors.grey.shade500,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
        6.verticalSpace,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.location_on,
              color: Colors.blue,
              size: 20,
            ),
            Flexible(
              child: Text(
                booking.address,
                // textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade500,
                ),
              ),
            ),
          ],
        ),
        const Divider(thickness: 1),
        12.verticalSpace,
      ],
    );
  }
}
