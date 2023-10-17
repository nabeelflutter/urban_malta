import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/constants/storage_manager.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/validation_dialogbox.dart';
import '../../../models/serializable_model/OrderListResponse.dart';
import '../../../warning_dialogue.dart';

class BookingWidget extends StatefulWidget {
  final String bookingstatus;
  final Function(String) menuItemClicked;
  final OrderListResponse booking;

  const BookingWidget(
      {Key? key,
      required this.booking,
      required this.menuItemClicked,
      required this.bookingstatus})
      : super(key: key);

  @override
  _BookingWidgetState createState() => _BookingWidgetState();
}

class _BookingWidgetState extends State<BookingWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                child: getImage(widget.booking),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              10.horizontalSpace,
              Container(
                height: 80,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      widget.booking.serviceData!.title!,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.values[4]),
                    ),
                    Container(
                      width: 200,
                      child: Text(
                        widget.booking.serviceData!.description!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(
                            color: AppColors.text_desc, fontSize: 12.sp),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '\€${widget.booking.totalPrice}',
                style: TextStyle(
                    color: AppColors.app_color,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: AppColors.divider,
          ),
          SizedBox(
            height: 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: ScreenUtil().setHeight(20),
                    backgroundImage: NetworkImage(
                      'https://urbanmalta.com/public/frontend/images/johnwing-app.png',
                    ),
                  ),
                  10.horizontalSpace,
                  Text(
                    this.widget.booking.userData!.firstName!,
                    style: TextStyle(
                        fontSize: 13,
                        // fontFamily: "Montserrat-Medium",
                        color: AppColors.text_desc),
                  ),
                ],
              ),
              BookingLabel(
                  widget.bookingstatus == "Active"
                      ? 0
                      : widget.bookingstatus == "Request"
                          ? 1
                          : widget.bookingstatus == "Completed"
                              ? 2
                              : 3,
                  context,
                  widget.menuItemClicked,
                  'accept')
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: AppColors.divider,
          ),
          SizedBox(
            height: 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                getDate(this.widget.booking.createdAt!),
                style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    // fontFamily: "Montserrat-SemiBold"
                    ),
              ),
              if (widget.bookingstatus == 'Active' ||
                  widget.bookingstatus == 'Request' ||
                  widget.bookingstatus == 'Cancel') ...{
                PopupMenuButton(
                  icon: const Text(
                    "...",
                    style: TextStyle(fontSize: 28, color: AppColors.app_black),
                  ),
                  itemBuilder: (context) {
                    return [
                      if (widget.bookingstatus == 'Request' &&
                          StorageManager().isProvider)
                        const PopupMenuItem(
                          value: 'accept',
                          child: Text(
                            'Request Accept',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppColors.app_color),
                          ),
                        ),
                      if (widget.bookingstatus == 'Request' &&
                          StorageManager().isProvider)
                        const PopupMenuItem(
                          value: 'cancel',
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ),
                      PopupMenuItem(
                        value: 'address',
                        child: Text(
                          'Get Directions',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      if (widget.bookingstatus == 'Active' &&
                          StorageManager().isProvider)
                        const PopupMenuItem(
                          value: 'cancel',
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ),
                      if (widget.bookingstatus == 'Active' &&
                          !StorageManager().isProvider)
                        const PopupMenuItem(
                          value: 'complete',
                          child: Text(
                            'Complete',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        )
                    ];
                  },
                  onSelected: (String value) {
                    if (value == 'address') {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            child: AlertDialog(
                              title: StorageManager().isProvider
                                  ? Text('Buyer Detail')
                                  : Text('Your Location Detail'),
                              content: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    _buildRow(
                                        Icons.home, widget.booking.location!),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    _buildRow(Icons.apartment,
                                        '${widget.booking.apartment_number}'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          launch(
                                              "tel://${widget.booking.userData?.phoneNumber}");
                                        },
                                        child:
                                            _buildRow(Icons.phone, 'Call Now')),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: Text('Get Directions'),
                                  onPressed: () {
                                    openMaps(
                                        double.parse(
                                            widget.booking.userData!.lat!),
                                        double.parse(
                                            widget.booking.userData!.lng!));
                                  },
                                ),
                                TextButton(
                                  child: Text('Cancel'),
                                  onPressed: () {
                                    // Handle Cancel button tap
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else if (value == 'accept') {
                      widget.menuItemClicked(value);
                    } else if (value == 'complete') {
                      widget.menuItemClicked(value);
                    } else if (value == 'cancel') {
                      widget.menuItemClicked(value);
                    }
                  },
                )
              }
            ],
          ),
        ]),
      ),
    ));
  }

  String getDate(dateTime) => DateFormat('dd MMM yyyy').format(dateTime);
}

BookingLabel(int i, context, Function(String) menuItemClicked, String value) {
  // if(i==3){
  //   return Container(
  //     height: 10,
  //     width: 20,
  //     color: Colors.red,
  //   );
  // }
  return SizedBox(
    height: 30,
    width: 90,
    child: TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(i == 0
            ? const Color(0x4995EB40)
            : i == 1
                ? Colors.blue
                : i == 2
                    ? const Color(0x34A85340)
                    : const Color(0xffFF0000).withOpacity(0.2)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      child: Text(
        i == 0
            ? "Active"
            : i == 1
                ? "Accept"
                : i == 2
                    ? "Completed"
                    : "Cancel",
        style: TextStyle(
          color: i == 0
              ? AppColors.app_color
              : i == 1
                  ? Colors.white
                  : i == 2
                      ? AppColors.color_green
                      : Color(0xFFFF0000),
          fontSize: 11,
          // fontFamily: 'Montserrat-SemiBold',
        ),
      ),
      onPressed: () {
        if (i == 1 && StorageManager().isProvider) {
          menuItemClicked(value);
        } else if (i == 1 && !StorageManager().isProvider) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return WarningDialog2Box(
                  title: 'Alert!',
                  descriptions:
                      'Only saller can accept request, afterwards it will be seen in active tab',
                  buttonTitle: 'ok',
                  buttonColor: AppColors.color_green,
                  icon: Icons.check,
                  onPressed: () {
                    print('ok');
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                );
              });
        }
        //  showDialog(
        //                             barrierDismissible: true,
        //                             context: context,
        //                             builder: (context) {
        //                               return DeletePopUp(

        //                               );
        //                             });

        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) =>
        //             ProviderDetailScreen(id: item.id!)));
      },
    ),
  );
}

getImage(OrderListResponse item) {
  if (item.gigdocument != null && item.gigdocument!.length > 0) {
    return Image.network(
        "https://urbanmalta.com/public/users/user_${item.gigdocument![0].userid}/documents/${item.gigdocument![0].fileName}",
        height: 80,
        width: 100,
        fit: BoxFit.fill);
  } else {
    return Image.asset('assets/images/barber.jpg',
        height: 80, width: 100, fit: BoxFit.fill);
  }
}

openMaps(double latitude, double longitude) async {
  final url =
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not open the map.';
  }
}

//-----------------------------Delete PopUP Menu------------------------------//
Widget _buildRow(IconData icon, String text) {
  return Row(
    children: [
      Icon(icon),
      Expanded(child: Center(child: Text(text))),
    ],
  );
}
