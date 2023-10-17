import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/constants/constants.dart';
import 'package:kappu/constants/storage_manager.dart';
import 'package:kappu/models/serializable_model/GigListResponse.dart';

import '../../../models/serializable_model/OrderListResponse.dart';
import '../../../net/base_dio.dart';
import '../../../net/http_client.dart';

class GigItemWidget extends StatefulWidget {
  final Function(String) menuItemClicked;
  final GigListResponse item;

  const GigItemWidget(
      {Key? key, required this.item, required this.menuItemClicked})
      : super(key: key);

  @override
  _GigItemWidgetState createState() => _GigItemWidgetState();
}

class _GigItemWidgetState extends State<GigItemWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 3,
        shadowColor: Colors.black.withOpacity(0.14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(right: 5),
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  double imageWidth = constraints.maxWidth * 0.4;
                  double imageHeight = constraints.maxHeight * 1.5;
                  double infoWidth = constraints.maxWidth * 0.5;

                  return Stack(
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(),
                            child: Container(
                              height: imageHeight,
                              width: imageWidth,
                              child: getImage(widget.item),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            // height: 140,
                            // width: 170,
                            width: infoWidth,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Container(
                                        padding: EdgeInsets.only(right: 14),
                                        child: Text(
                                          widget.item.title ?? "",
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Color(0xff7B7D83),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Text(
                                        widget.item.ratingCount ?? "0.0",
                                        style: TextStyle(
                                          color: Color(0xffF79E1F),
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        widget.item.reviewCount != null
                                            ? "(${widget.item.reviewCount} Rating)"
                                            : "(0 Rating)",
                                        style: TextStyle(
                                          color: Color(0xff7B7D83),
                                          fontSize: 15,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Hourly Price',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xff161616),
                                      ),
                                    ),
                                    Text(
                                      '\€ ${widget.item.servicepackages?.price}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Color(0xff161616),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 0,
                        right: 0,

                        // left: 350,
                        child: PopupMenuButton(
                          icon: Transform.rotate(
                            angle: 110, // 90 degrees in radians (pi/2)
                            child: const Icon(
                              Icons
                                  .more_vert, // Replace '...' with the desired icon, e.g., Icons.more_vert
                              size: 24,
                              color: AppColors.app_black,
                            ),
                          ),
                          itemBuilder: (context) {
                            return [
                              const PopupMenuItem(
                                value: 'edit',
                                child: Text(
                                  'Edit GIG',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.app_color,
                                  ),
                                ),
                              ),
                              const PopupMenuItem(
                                value: 'delete',
                                child: Text(
                                  'Delete',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ];
                          },
                          onSelected: widget.menuItemClicked,
                        ),
                      ),
                    ],
                  );

                  // return Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Container(
                  //       width: imageWidth,
                  //       child: getImage(widget.item),
                  //     ),
                  //     Container(
                  //       width: infoWidth,
                  //       child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //         children: [
                  //           Row(children: [
                  //             Container(
                  //               width:
                  //                   150, // Set the desired maximum width here
                  //               child: Text(
                  //                 widget.item.title ?? "",
                  //                 style: TextStyle(
                  //                   fontSize: 15,
                  //                   color: Color(0xff7B7D83),
                  //                 ),
                  //               ),
                  //             ),
                  //             Spacer(),
                  //             PopupMenuButton(
                  //               icon: Transform.rotate(
                  //                 angle: 110, // 90 degrees in radians (pi/2)
                  //                 child: Icon(
                  //                   Icons
                  //                       .more_vert, // Replace '...' with the desired icon, e.g., Icons.more_vert
                  //                   size: 28,
                  //                   color: AppColors.app_black,
                  //                 ),
                  //               ),
                  //               itemBuilder: (context) {
                  //                 return [
                  //                   const PopupMenuItem(
                  //                     value: 'edit',
                  //                     child: Text(
                  //                       'Edit GIG',
                  //                       style: TextStyle(
                  //                         fontWeight: FontWeight.w500,
                  //                         color: AppColors.app_color,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   const PopupMenuItem(
                  //                     value: 'delete',
                  //                     child: Text(
                  //                       'Delete',
                  //                       style: TextStyle(
                  //                         fontWeight: FontWeight.w500,
                  //                         color: Colors.black,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ];
                  //               },
                  //               onSelected: widget.menuItemClicked,
                  //             ),
                  //           ]),
                  //           Row(
                  //             children: [
                  //               Text(
                  //                 '4.5',
                  //                 style: TextStyle(
                  //                   color: Color(0xffF79E1F),
                  //                   fontSize: 15,
                  //                 ),
                  //               ),
                  //               SizedBox(width: 10),
                  //               Text(
                  //                 '(125 Rating)',
                  //                 style: TextStyle(
                  //                   color: Color(0xff7B7D83),
                  //                   fontSize: 15,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //           Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Text(
                  //                 'Hourly Price',
                  //                 style: TextStyle(
                  //                   fontSize: 15,
                  //                   color: Color(0xff161616),
                  //                 ),
                  //               ),
                  //               Text(
                  //                 '\€ ${widget.item.servicepackages?.price}',
                  //                 style: TextStyle(
                  //                   fontSize: 18,
                  //                   color: Color(0xff161616),
                  //                   fontWeight: FontWeight.w700,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getDate(dateTime) => DateFormat('dd MMM yyyy').format(dateTime);
}

//
// class _GigItemWidgetState extends State<GigItemWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//         onTap: () {},
//         child: Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15.0),
//           ),
//           elevation: 3,
//           shadowColor: Colors.black.withOpacity(0.14),
//           child: Padding(
//             padding: EdgeInsets.all(15.h),
//             child:
//                 Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               Row(
//                 children: [
//                   Container(
//                     child: getImage(widget.item),
//                     decoration: new BoxDecoration(
//                       color: Colors.white,
//                       borderRadius:
//                           new BorderRadius.all(new Radius.circular(10)),
//                     ),
//                   ),
//                   10.horizontalSpace,
//                   Container(
//                     height: 80,
//                     child: Column(
//                       mainAxisSize: MainAxisSize.max,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Text(
//                           widget.item.title ?? "",
//                           textAlign: TextAlign.start,
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 14.sp,
//                               fontWeight: FontWeight.values[4]),
//                         ),
//                         Container(
//                           width: 200,
//                           child: Text(
//                             widget.item.description!,
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                             softWrap: false,
//                             style: TextStyle(
//                                 color: AppColors.text_desc, fontSize: 12.sp),
//                           ),
//                         ),
//                         Text(
//                           '\€ ${widget.item.servicepackages?.price}',
//                           style: TextStyle(
//                               color: AppColors.app_color,
//                               fontSize: 14.sp,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: 6,
//               ),
//               Container(
//                 height: 1,
//                 width: MediaQuery.of(context).size.width,
//                 color: AppColors.divider,
//               ),
//               SizedBox(
//                 height: 6,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     getDate(this.widget.item.createdAt!),
//                     style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.black,
//                         fontFamily: "Montserrat-SemiBold"),
//                   ),
//                   PopupMenuButton(
//                     icon: const Text(
//                       "...",
//                       style:
//                           TextStyle(fontSize: 28, color: AppColors.app_black),
//                     ),
//                     itemBuilder: (context) {
//                       return [
//                         const PopupMenuItem(
//                           value: 'edit',
//                           child: Text(
//                             'Edit GIG',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w500,
//                                 color: AppColors.app_color),
//                           ),
//                         ),
//                         const PopupMenuItem(
//                           value: 'delete',
//                           child: Text(
//                             'Delete',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.black),
//                           ),
//                         ),
//                       ];
//                     },
//                     onSelected: widget.menuItemClicked,
//                   )
//                 ],
//               ),
//             ]),
//           ),
//         ));
//   }
//
//   String getDate(dateTime) => DateFormat('dd MMM yyyy').format(dateTime);
// }
//
getImage(GigListResponse item) {
  if (item.servicepackages != null &&
      item.servicepackages?.gigdocument != null &&
      item.servicepackages!.gigdocument!.length > 0) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12), // Set the desired border radius
      child: Image.network(
        Constants.BASE_URL +
            "/public/users/user_${item.servicepackages?.gigdocument![0].userid}/documents/${item.servicepackages?.gigdocument![0].fileName}",
        height: 150,
        width: 100,
        fit: BoxFit
            .cover, // Use BoxFit.cover to maintain the aspect ratio and clip any overflow
      ),
    );
  } else {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        bottomLeft: Radius.circular(12),
      ),
      child: Image.asset(
        'assets/images/barber.jpg',
        height: 125,
        width: 130,
        fit: BoxFit.cover,
      ),
    );
  }
}
