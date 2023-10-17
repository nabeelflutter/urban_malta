import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/constants/storage_manager.dart';
import 'package:kappu/gg.dart';
import 'package:kappu/net/http_client.dart';
import 'package:kappu/provider/provider_provider.dart';
import 'package:kappu/provider/userprovider.dart';
import 'package:kappu/screens/add_review/add_review.dart';
import 'package:kappu/screens/bookings/widgets/booking_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:lottie/lottie.dart';
import '../../models/serializable_model/OrderListResponse.dart';
import '../../net/base_dio.dart';
import 'package:kappu/main.dart';
//bool isNew=false;

class BookingScreen extends StatefulWidget {
  BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  late int? count;
  late Timer _timer;

  List<OrderListResponse> updatedList = []; //
  List<OrderListResponse> originalList = []; // List from the future
// List to store updated data

//  late Future<List<OrderListResponse>> future;

  reloadpage() {
    setState(() {});
  }

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState

    _timer = Timer.periodic(Duration(minutes: 1), (Timer t) {
      print('printing osm');
      checkIfNewData();
    });

    reloadpage();

    super.initState();
  }

  BuildContext? _scaffoldContext;
  Future<bool> _onWillPop() async {
    if (_scaffoldContext != null) {
      Navigator.pushAndRemoveUntil(
        _scaffoldContext!,
        MaterialPageRoute(
          builder: (BuildContext context) => InitialScreen(),
        ),
        (route) => false,
      );
    }
    return false;
  }

  checkIfNewData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    updatedList = await HttpClient().getrequestedbookings(
        StorageManager().userId.toString(),
        "Bearer " + StorageManager().accessToken,
        StorageManager().isProvider ? "provider" : "user");
    print(
        'printing update list lenth ${updatedList.length} printing origional list ${originalList.length}');

    if (originalList.length != updatedList.length &&
        originalList.length != null &&
        originalList.isNotEmpty) {
      print(
          'printinggg update list lenth ${updatedList.length} printing origional list ${originalList.length}');

      // sharedPreferences.setBool('bol', true);
      setState(() {
        StorageManager().setNotificationIcon = true;

        //isNew=sharedPreferences.getBool('bol')!;
        updatedList.clear();
        originalList.clear();
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scaffoldContext = context;
    return WillPopScope(
        onWillPop: _onWillPop,
        child: DefaultTabController(
          length: 4,
          child: Scaffold(
            backgroundColor: AppColors.app_bg,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(ScreenUtil().setHeight(100)),
              child: AppBar(
                bottom: TabBar(
                  indicatorWeight: 4,
                  indicatorColor: AppColors.app_color,
                  labelColor: AppColors.app_color,
                  unselectedLabelColor: Colors.black,
                  isScrollable: true,
                  labelStyle: TextStyle(
                      // fontFamily: "Montserrat-Bold",
                      fontSize: 14,
                      color: Colors.black),
                  tabs: [
                    Tab(
                      text: 'Active',
                    ),
                    Container(
                        child: Row(
                      children: [
                        Tab(text: "Requests"),
                        StorageManager().getNotificationIcon
                            ? InkWell(
                                onTap: () async {
                                  SharedPreferences sharedPreferences =
                                      await SharedPreferences.getInstance();
                                  sharedPreferences.setBool('bol', false);
                                  // Handle notification icon pressed
                                  setState(() {
                                    StorageManager().setNotificationIcon =
                                        false; // Reset notification flag
                                  });
                                },
                                child: Container(
                                    padding: EdgeInsets.all(6),
                                    margin: EdgeInsets.all(2),
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white),
                                    child: Image(
                                      image: AssetImage(
                                          'assets/images/notiii.png'),
                                    )),
                              )
                            : SizedBox()
                      ],
                    )),
                    Tab(
                      text: "Completed",
                    ),
                    Tab(
                      text: "Cancel",
                    ),
                  ],
                ),
                leading: IconButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => InitialScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: AppColors.iconColor,
                    )),
                title: Stack(
                  children: [
                    Column(
                      children: [
                        Text("Manage Order",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              // fontFamily: "Montserrat-Bold"
                            )),
                      ],
                    ),
                    if (isLoading) const SizedBox()
                  ],
                ),
                backgroundColor: Colors.white,
                shadowColor: Colors.white,
                elevation: 2,
              ),
            ),
            body: Consumer<UserProvider>(
              builder: (context, loggedinuser, child) =>
                  Consumer<ProviderProvider>(
                builder: (context, loggedinprovider, child) {
                  return TabBarView(children: [
                    FutureBuilder(
                        future: HttpClient().getActivebookings(
                            StorageManager().userId.toString(),
                            "Bearer " + StorageManager().accessToken,
                            StorageManager().isProvider ? "provider" : "user"),
                        builder: (context,
                            AsyncSnapshot<List<OrderListResponse>> snapshot) {
                          if (snapshot.connectionState !=
                              ConnectionState.done) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.data == null || snapshot.data!.isEmpty) {
                            return Padding(
                              padding: EdgeInsets.only(top: 20.h),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Lottie.asset(
                                          "animation/manage_order.json",
                                          options: LottieOptions(
                                              enableMergePaths: true))),
                                  const Text("No Active Bookings ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        // fontFamily: "Montserrat-Regular"
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        setState(() {});
                                      },
                                      child: const Text('Reload')),
                                  // TextButton(
                                  //     onPressed: () {
                                  //       setState(() {});
                                  //     },
                                  //     child: const Text('Reload')),
                                ],
                              ),
                            );
                          }

                          return ListView(
                            padding: const EdgeInsets.only(bottom: 50),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: snapshot.data!
                                .map((item) => Padding(
                                      padding: EdgeInsets.all(
                                          ScreenUtil().setHeight(10)),
                                      child: BookingWidget(
                                        bookingstatus: 'Active',
                                        booking: item,
                                        menuItemClicked: (String value) {
                                          callAPI(context, item, value,
                                              item.id.toString());
                                        },
                                      ),
                                    ))
                                .toList(),
                          );
                        }),
                    FutureBuilder(
                        future: HttpClient().getrequestedbookings(
                            StorageManager().userId.toString(),
                            "Bearer " + StorageManager().accessToken,
                            StorageManager().isProvider ? "provider" : "user"),
                        builder: (context,
                            AsyncSnapshot<List<OrderListResponse>> snapshot) {
                          if (snapshot.connectionState !=
                              ConnectionState.done) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.data == null || snapshot.data!.isEmpty) {
                            return Padding(
                              padding: EdgeInsets.only(top: 20.h),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Lottie.asset(
                                          "animation/manage_order.json",
                                          options: LottieOptions(
                                              enableMergePaths: true))),
                                  const Text("No Requests for Bookings "),
                                  TextButton(
                                      onPressed: () {
                                        setState(() {});
                                      },
                                      child: const Text('Reload'))
                                ],
                              ),
                            );
                          }
                          originalList = snapshot.data!;
                          print(
                              'printing origional list ${originalList.length} dusri ${updatedList.length}');
                          return ListView(
                            padding: const EdgeInsets.only(bottom: 50),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: originalList
                                .map((item) => Padding(
                                      padding: EdgeInsets.all(
                                          ScreenUtil().setHeight(10)),
                                      child: InkWell(
                                        /* onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                      return TestScreen();
                                    },));
                                  },*/
                                        child: BookingWidget(
                                          bookingstatus: 'Request',
                                          booking: item,
                                          menuItemClicked: (String value) {
                                            callAPI(context, item, value,
                                                item.id.toString());
                                          },
                                        ),
                                      ),
                                    ))
                                .toList(),
                          );
                        }),
                    FutureBuilder(
                        future: HttpClient().getcompletedbooking(
                            StorageManager().userId.toString(),
                            "Bearer " + StorageManager().accessToken,
                            StorageManager().isProvider ? "provider" : "user"),
                        builder: (context,
                            AsyncSnapshot<List<OrderListResponse>> snapshot) {
                          if (snapshot.connectionState !=
                              ConnectionState.done) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.data == null || snapshot.data!.isEmpty) {
                            return Padding(
                              padding: EdgeInsets.only(top: 20.h),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Lottie.asset(
                                          "animation/manage_order.json",
                                          options: LottieOptions(
                                              enableMergePaths: true))),
                                  const Text("No Completed Bookings "),
                                  TextButton(
                                      onPressed: () {
                                        setState(() {});
                                      },
                                      child: const Text('Reload'))
                                ],
                              ),
                            );
                          }
                          return ListView(
                            padding: const EdgeInsets.only(bottom: 50),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: snapshot.data!
                                .map((item) => Padding(
                                      padding: EdgeInsets.all(
                                          ScreenUtil().setHeight(10)),
                                      child: BookingWidget(
                                        bookingstatus: "Completed",
                                        booking: item,
                                        menuItemClicked: (String value) {
                                          callAPI(context, item, value,
                                              item.id.toString());
                                        },
                                      ),
                                    ))
                                .toList(),
                          );
                        }),
                    FutureBuilder(
                        future: HttpClient().getCancelledbooking(
                            StorageManager().userId.toString(),
                            "Bearer " + StorageManager().accessToken,
                            StorageManager().isProvider ? "provider" : "user"),
                        builder: (context,
                            AsyncSnapshot<List<OrderListResponse>> snapshot) {
                          if (snapshot.connectionState !=
                              ConnectionState.done) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.data == null || snapshot.data!.isEmpty) {
                            return Padding(
                              padding: EdgeInsets.only(top: 20.h),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Lottie.asset(
                                          "animation/manage_order.json",
                                          options: LottieOptions(
                                              enableMergePaths: true))),
                                  const Text("No Cancelled Bookings "),
                                  TextButton(
                                      onPressed: () {
                                        setState(() {});
                                      },
                                      child: const Text('Reload'))
                                ],
                              ),
                            );
                          }
                          return ListView(
                            padding: const EdgeInsets.only(bottom: 50),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: snapshot.data!
                                .map((item) => Padding(
                                      padding: EdgeInsets.all(
                                          ScreenUtil().setHeight(10)),
                                      child: BookingWidget(
                                        bookingstatus: "Cancel",
                                        booking: item,
                                        menuItemClicked: (String value) {
                                          callAPI(context, item, value,
                                              item.id.toString());
                                        },
                                      ),
                                    ))
                                .toList(),
                          );
                        }),
                  ]);
                },
              ),
            ),
          ),
        ));
  }

  Future<void> callAPI(BuildContext context, OrderListResponse item,
      String value, String bookingId) async {
    setState(() {
      isLoading = true;
    });
    if (value == 'complete') {
      await HttpClient()
          .completeOrder(
              bookingId.toString(), "Bearer " + StorageManager().accessToken)
          .then((value) {
        setState(() {
          isLoading = false;
        });
        if (value.status!) {
          // reloadpage();
          pushDynamicScreen(context,
              screen: AddReview(booking: item, setbookingstate: () {}),
              withNavBar: false);
        }
      }).catchError((e) {
        setState(() {
          isLoading = false;
        });
        BaseDio.getDioError(e);
      });
    } else if (value == 'accept') {
      await HttpClient()
          .acceptOrder(
              bookingId.toString(), "Bearer " + StorageManager().accessToken)
          .then((value) {
        if (value.status) {
          setState(() {
            isLoading = false;
          });
          reloadpage();
        }
      }).catchError((e) {
        setState(() {
          isLoading = false;
        });
        BaseDio.getDioError(e);
      });
    } else if (value == 'cancel') {
      await HttpClient()
          .cancelOrder(
              bookingId.toString(), "Bearer " + StorageManager().accessToken)
          .then((value) {
        if (value.status) {
          setState(() {
            isLoading = false;
          });
          reloadpage();
        }
      }).catchError((e) {
        setState(() {
          isLoading = false;
        });
        BaseDio.getDioError(e);
      });
    }
  }
}
