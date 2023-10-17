import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/models/serializable_model/booking.dart';

import '../../../common/customtexts.dart';

class OrderPriceSummary extends StatelessWidget {
  final Booking booking;
  const OrderPriceSummary({Key? key, required this.booking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
            children: booking.boughtpackages
                .map(
                  (package) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Text(
                          '${package.quantity} \u2022 ',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp),
                        ),
                        Text(
                          package.package.packagetitle,
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp),
                        ),
                      ]),
                      Text(
                        r'$' '${package.price}',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp),
                      ),
                    ],
                  ),
                )
                .toList()),
        15.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customtext(
              buttontext: 'Service Extra',
              color: Colors.grey,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            customtext(
              buttontext: r'$' '${12.5}',
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ],
        ),
        6.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customtext(
              buttontext: 'Est. Tax',
              color: Colors.grey,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            customtext(
              buttontext: r'$' '${10.7}',
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ],
        ),
        const Divider(thickness: 1),
        10.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customtext(
              buttontext: 'Total',
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            customtext(
              buttontext: r'$' '${booking.totalprice}',
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ],
        ),
        10.verticalSpace,
      ],
    );
  }
}
