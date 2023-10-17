import 'dart:async';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/constants/storage_manager.dart';
import 'package:kappu/models/location_model.dart';
import 'package:kappu/models/serializable_model/RecommendedServiceProvidersResponse.dart';
import 'package:kappu/screens/catagories/search_catagories_screen.dart';
import 'package:kappu/screens/home_page/widgets/best_services.dart';
import 'package:kappu/screens/home_page/widgets/slider.dart';
import 'package:kappu/screens/location/add_new_address_screen.dart';
import 'package:kappu/screens/location/choose_location_screen.dart';
import 'package:kappu/screens/login/login_screen.dart';
import 'package:kappu/screens/settings/settings_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/promo_model.dart';
import '../../models/serializable_model/CategoryResponse.dart';
import '../../models/serializable_model/PopularServiceListResponse.dart';
import '../../net/http_client.dart';
import '../ProviderScreens/provider_detail.dart';
import '../homescreen/home.dart';
import '../slider_offers.dart';
import 'widgets/search_text_field.dart';
import 'widgets/services_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  var currentBackPressTime;
  Future<PromoResponse>? _future;

  String loc = 'Malta';
  double latitude = 0.0;
  double longitude = 0.0;

  int pageNumber = 0;
  final CarouselController _controller = CarouselController();

  LocationModel? locationModel;

  // ***********popular service api *********
  Future<List<PopularServiceListResponse>>? futureData;

//////************** ppopular service api ********** */

//********  best service api ************ */
  Future<CategoryResponse>? categoryData;

  @override
  bool get wantKeepAlive => true;

  @override
  initState() {
    _future = fetchData();
    fetchLocation();
    categoryData = HttpClient().getCatagory();
    super.initState();
  }

  Future<PromoResponse> fetchData() async {
    const url =
        'https://urbanmalta.com/api/home/'; // Replace with the actual API endpoint

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      print('printing Presponse ${response.body.toString()}');

      return PromoResponse.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<void> getLoc() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString('currentLocation') == null &&
        StorageManager().userId != -1) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          // return LocationScreen(password: 'password');
          return const ChooseLocationScreen();
        },
      ));
    } else {
      setState(() {
        loc = preferences.getString('currentLocation') ?? '';
      });
    }
  }

  Future<void> fetchLocation() async {
    if (StorageManager().userId == -1) {
      return;
    }
    print("ll");

    print(StorageManager().userId);
    final url =
        'https://urbanmalta.com/api/location/list/${StorageManager().userId}'; // Replace with the actual API endpoint

    print(url);

    var headers = {
      'Authorization': 'Bearer ${StorageManager().accessToken}',
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6ImVkeEllU2F2aUo2eHpRd1F1cTFSdmc9PSIsInZhbHVlIjoieFJlMkk1MVRKalpjdXVEaWJrYnFJVXlhRnYrdFAvZy9lUS9zUTFJZ21aOTMvQWpseXJYeWhVWXhoeW54NnZ5U3Y1NXA5RHJHMmx0RVhwSlBNTUoxM3lOYTNkMDZIa3hObDM0aFMrQy9aSGNsQnpBYXpXOG1RbGVYNE5ycDc3Y2giLCJtYWMiOiI5OWYxNzM2ZTcxNGNmOGQ1NWNlOWY3ZDdiYTk1ZjUyN2ZiY2VmYTc5NzcxY2Y0MjhiM2I5ZDU3NzlkOWI2MGYxIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6Ik9ubVRlRXIxb2EwU0lEY0JRVldJdXc9PSIsInZhbHVlIjoidkF5Tmw2dzZZcUxNY1lpTFp5dzdUNWlxKzVoT2hxZUErb3E1QnU5ZDQ4bkJTaUYrQlh1MW5wR3pkWTdQNzg4SEZFMHVDVEF4WVU4ZHFDOXh3cEx5WEp5OUJvMWE5c3BxM1c4N1NqMnAzaXR2ejZPNTJyTDVOVVpiTjlWSzNqUlQiLCJtYWMiOiJjZDM3NGM1ZDI5ZDBjMjU0NTVlZjgzM2QxYWNjZjRmZGRmMGE5YTMwOTdjNzc0OTI1ZDU2MTEzOTNiM2Y4ODI2IiwidGFnIjoiIn0%3D'
    };
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      print('printing location ${response.body.toString()}');

      locationModel = LocationModel.fromJson(jsonResponse);

      if (locationModel != null && locationModel!.data.isNotEmpty) {
        loc = locationModel!.data.firstWhere(
          (element) => element.isDefault == '1',
          orElse: () {
            return LocationData(
                id: 1,
                userId: '',
                name: "Malta",
                lat: '',
                lng: '',
                type: '',
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
                isDefault: '');
          },
        ).name;
      }
      if (locationModel != null && locationModel!.data.isNotEmpty) {
        final lat = locationModel!.data.firstWhere(
          (element) => element.isDefault == '1',
          orElse: () {
            return LocationData(
                id: 1,
                userId: '',
                name: "Malta",
                lat: locationModel!.data[0].lat,
                lng: locationModel!.data[0].lng,
                type: '',
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
                isDefault: '');
          },
        ).lat;

        final long = locationModel!.data.firstWhere(
          (element) => element.isDefault == '1',
          orElse: () {
            return LocationData(
                id: 1,
                userId: '',
                name: "Malta",
                lat: locationModel!.data[0].lat,
                lng: locationModel!.data[0].lat,
                type: '',
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
                isDefault: '');
          },
        ).lng;
        futureData = HttpClient().getPopularServices(lat, long);
        final shared = await SharedPreferences.getInstance();
        shared.setString('lat', lat);
        shared.setString('long', long);
        latitude = double.parse(lat);
        longitude = double.parse(long);
      }

      setState(() {});
      if (locationModel?.data.isEmpty ?? true) {
        getLoc();
      }
    } else {
      print("location error");
      // throw Exception('Failed to fetch data');
    }
  }

  Future<void> _locationSheet() async {
    if (StorageManager().userId == -1) {
      bottomSheetForSignIn(context);
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xfff6f9fe),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: StatefulBuilder(builder: (context, set) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "Location",
                            style: TextStyle(
                              color: AppColors.app_black,
                              fontSize: 28,
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              }
                            },
                            icon: const Icon(Icons.close))
                      ],
                    ),
                    const SizedBox(height: 15),
                    ListView.builder(
                      itemCount: locationModel?.data.length ?? 0,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final locData = locationModel?.data.elementAt(index);
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: InkWell(
                            onTap: () async {
                              if (await setDefault(locData!.id)) {
                                for (var element in locationModel!.data) {
                                  if (element.id == locData.id) {
                                    set(() {
                                      element.isDefault = '1';
                                    });
                                  } else {
                                    set(() {
                                      element.isDefault = '0';
                                    });
                                  }
                                }
                              }
                              futureData = HttpClient()
                                  .getPopularServices(locData.lat, locData.lng);

                              setState(() {});
                              if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              }
                            },
                            borderRadius: BorderRadius.circular(10),
                            child: Ink(
                              height: 65,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 12),
                              child: Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: locData?.isDefault == '1'
                                            ? AppColors.app_color
                                            : Colors.grey.withOpacity(0.5),
                                        shape: BoxShape.circle),
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.location_city,
                                      color: locData?.isDefault == '1'
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            locationModel?.data
                                                    .elementAt(index)
                                                    .name ??
                                                "",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: locData?.isDefault == '1'
                                                  ? AppColors.app_color
                                                  : AppColors.app_black,
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            locationModel?.data
                                                    .elementAt(index)
                                                    .type ??
                                                "",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: locData?.isDefault == '1'
                                                  ? AppColors.app_color
                                                  : AppColors.app_black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (locData!.isDefault == '1')
                                    const Icon(
                                      Icons.check,
                                      size: 28,
                                      color: Colors.lightGreenAccent,
                                    )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    InkWell(
                      onTap: () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                          builder: (context) => AddNewAddressScreen(),
                        ))
                            .then((value) {
                          fetchLocation();
                        });
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Ink(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 12),
                        child: const Row(
                          children: [
                            Icon(Icons.add),
                            SizedBox(width: 20),
                            Text(
                              "Add new address",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: AppColors.app_black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () async {
                        //todo
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Ink(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 12),
                        child: const Row(
                          children: [
                            Icon(Icons.menu),
                            SizedBox(width: 20),
                            Text(
                              "Browse all wolt cities",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: AppColors.app_black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Future<bool> setDefault(int id) async {
    var headers = {
      'Authorization': 'Bearer ${StorageManager().accessToken}',
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6ImVkeEllU2F2aUo2eHpRd1F1cTFSdmc9PSIsInZhbHVlIjoieFJlMkk1MVRKalpjdXVEaWJrYnFJVXlhRnYrdFAvZy9lUS9zUTFJZ21aOTMvQWpseXJYeWhVWXhoeW54NnZ5U3Y1NXA5RHJHMmx0RVhwSlBNTUoxM3lOYTNkMDZIa3hObDM0aFMrQy9aSGNsQnpBYXpXOG1RbGVYNE5ycDc3Y2giLCJtYWMiOiI5OWYxNzM2ZTcxNGNmOGQ1NWNlOWY3ZDdiYTk1ZjUyN2ZiY2VmYTc5NzcxY2Y0MjhiM2I5ZDU3NzlkOWI2MGYxIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6Ik9ubVRlRXIxb2EwU0lEY0JRVldJdXc9PSIsInZhbHVlIjoidkF5Tmw2dzZZcUxNY1lpTFp5dzdUNWlxKzVoT2hxZUErb3E1QnU5ZDQ4bkJTaUYrQlh1MW5wR3pkWTdQNzg4SEZFMHVDVEF4WVU4ZHFDOXh3cEx5WEp5OUJvMWE5c3BxM1c4N1NqMnAzaXR2ejZPNTJyTDVOVVpiTjlWSzNqUlQiLCJtYWMiOiJjZDM3NGM1ZDI5ZDBjMjU0NTVlZjgzM2QxYWNjZjRmZGRmMGE5YTMwOTdjNzc0OTI1ZDU2MTEzOTNiM2Y4ODI2IiwidGFnIjoiIn0%3D'
    };

    print("kk $id");
    var data = FormData.fromMap({
      'user_id': '${StorageManager().userId}',
      'id': '$id',
      'is_default': '1'
    });

    var dio = Dio();
    var response = await dio.request(
      'https://urbanmalta.com/api/location/default',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      unawaited(fetchLocation());
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onLongPress: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  // return LocationScreen(password: 'password');
                                  return const ChooseLocationScreen();
                                },
                              ));
                            },
                            onTap: _locationSheet,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 30,
                                  color: AppColors.app_color,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Current location',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff7B7D83)),
                                      ),
                                      Text(
                                        loc ?? 'Malta',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Color(0xff7B7D83)),
                                        maxLines: 1,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (loc.isEmpty) Spacer(),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: CircleAvatar(
                                  // radius: 30,
                                  backgroundColor: Colors.white,
                                  child: IconButton(
                                    onPressed: () {
                                      if (StorageManager()
                                          .accessToken
                                          .isNotEmpty) {
                                        pushDynamicScreen(context,
                                            screen: SettingsRoutePage(),
                                            withNavBar: false);
                                      } else {
                                        bottomSheetForSignIn(context);
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.account_circle_outlined,
                                      color: AppColors.app_color,
                                      size: 30,
                                    ),
                                  )),
                            ),
                            if (StorageManager().accessToken.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return const Homepage();
                                      },
                                    ));
                                  },
                                  icon: const Icon(
                                    Icons.account_balance_wallet_rounded,
                                    color: Color(
                                        0xFF4995EB), // Set the color to #4995EB
                                    size: 30.0,
                                  ),
                                  // icon: const Icon(
                                  //   Icons.notifications,
                                  //   color: Colors.grey,
                                  // ),
                                ),
                              ),
                          ],
                        )
                      ],
                    ),
                  ),
                  // const SizedBox(height: 5,),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Image.asset(
                  //       'assets/images/colorfulLogo.png',
                  //       width: MediaQuery.of(context).size.width * 0.14,
                  //       height: MediaQuery.of(context).size.height * 0.05,
                  //     ),
                  //     Text(
                  //       'URBAN MALTA',
                  //       style: TextStyle(
                  //           fontSize: 22,
                  //           color: AppColors.app_color,
                  //           fontWeight: FontWeight.bold),
                  //     )
                  //   ],
                  // ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(6)),
                      child: GestureDetector(
                        onTap: () {},
                        child: SearchTextField(
                          enable: true,
                          hintext: "Search Services",
                          value: "",
                          onSearchingComplete: (value) {
                            print('aaaa');
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    SearchCatagoriesScreen(searchtext: value)));
                          },
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),

              /*Container(
                height: ScreenUtil().setHeight(160),
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                      child: Row(children: [
                        Image.asset(
                          'assets/images/colorfulLogo.png',
                          width: MediaQuery.of(context).size.width * 0.14,
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.fromLTRB(5, 2, 2, 2.0),
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     children: [
                        //       Text("Current Location",
                        //           style: TextStyle(
                        //               color: AppColors.title_desc,
                        //               fontSize: ScreenUtil().setSp(10),
                        //               fontWeight: FontWeight.w500)),
                        //       Text("Germany",
                        //           style: TextStyle(
                        //               color: AppColors.text_desc,
                        //               fontSize: ScreenUtil().setSp(14),
                        //               fontWeight: FontWeight.w500))
                        //     ],
                        //   ),
                        // ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: CircleAvatar(
                              // radius: 30,
                              backgroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () {
                                  // if (StorageManager().accessToken.isNotEmpty) {
                                  pushDynamicScreen(context,
                                      screen: SettingsPage(), withNavBar: false);
                                  // } else {
                                  //   changeScreen(
                                  //       context: context,
                                  //       screen: LoginScreen(isFromOtherScreen: true));
                                  // }
                                },
                                icon: const Icon(
                                  Icons.account_circle_outlined,
                                  color: AppColors.app_color,
                                ),
                              )),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(15),
                        )
                      ]),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(15),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(6)),
                      child: SearchTextField(
                        hintext: "Search Services",
                        onSearchingComplete: () {},
                      ),
                    )
                  ],
                ),
              ),*/
              Expanded(
                  child: Container(
                color: AppColors.color_f2f7fd,
                child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      children: [
                        20.verticalSpace,
                        /*  CarouselSlider(
                          carouselController: _controller,
                          items: [
                            Container(
                              // margin: EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                // color: Colors.amber,
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  image: AssetImage("assets/img/computer.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              // margin: EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  image: AssetImage("assets/img/plumber.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              // margin: EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  image: AssetImage("assets/img/elec.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              // margin: EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  image: AssetImage("assets/img/doctor.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                          options: CarouselOptions(
                              height: 180.0,
                              enlargeCenterPage: true,
                              autoPlay: true,
                              aspectRatio: 16 / 9,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enableInfiniteScroll: true,
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 800),
                              viewportFraction: 0.8,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  pageNumber = index;
                                });
                              }),
                        ),*/
                        SliderWidget(
                          lat: latitude,
                          lng: longitude,
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 20, bottom: 5),
                          child: Text(
                            'Popular Services',
                            style: TextStyle(
                                color: AppColors.app_color,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(18)),
                          ),
                        ),
                        if (futureData != null)
                          Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: OurBestServices(
                              futureData: futureData!,
                              lat: latitude,
                              lng: longitude,
                            ),
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: Colors.white,
                                onTap: () {},
                                child: Container(
                                    height: h * .03,
                                    width: w * .066,
                                    // color: Colors.blue,
                                    child: const Center(
                                        // child:
                                        // Text(
                                        //   "View All",
                                        //   style: TextStyle(
                                        //       color: AppColors.app_color,
                                        //       fontSize: 11),
                                        // ),
                                        )),
                              ),
                            ),
                            // Container(
                            //   height: h * .03,
                            //   width: w * .07,
                            //   // margin: EdgeInsets.all(5),
                            //   // padding: EdgeInsets.all(),
                            //   decoration: const BoxDecoration(
                            //       color: Colors.white, shape: BoxShape.circle),
                            //   child: const Icon(
                            //     Icons.arrow_forward_ios,
                            //     color: Color(0xff4995EB),
                            //     size: 13,
                            //   ),
                            // )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 20, bottom: 5, top: 5),
                          child: Text(
                            'Best Services',
                            style: TextStyle(
                                color: AppColors.app_color,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(18)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Servicescontainer(
                            categoryData: categoryData,
                            lat: latitude,
                            lng: longitude,
                          ),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     Container(
                        //       height: h * .04,
                        //       width: w * .14,
                        //       // color: Colors.amber,
                        //       margin: EdgeInsets.only(left: 2, right: 2),
                        //       child: Row(
                        //         children: [
                        //           Material(
                        //             color: Colors.transparent,
                        //             child: InkWell(
                        //               splashColor: Colors.white,
                        //               onTap: () {},
                        //               child: Container(
                        //                   height: h * .03,
                        //                   width: w * .066,
                        //                   // color: Colors.blue,
                        //                   child: const Center(
                        //                       // child: Text(
                        //                       //   "View All",
                        //                       //   style: TextStyle(
                        //                       //       color: AppColors.app_color,
                        //                       //       fontSize: 11),
                        //                       // ),
                        //                       )),
                        //             ),
                        //           ),
                        //           Container(
                        //             height: h * .03,
                        //             width: w * .07,
                        //             // margin: EdgeInsets.all(5),
                        //             // padding: EdgeInsets.all(),
                        //             decoration: const BoxDecoration(
                        //                 color: Colors.white,
                        //                 shape: BoxShape.circle),
                        //             child: const Icon(
                        //               Icons.arrow_forward_ios,
                        //               color: Color(0xff4995EB),
                        //               size: 13,
                        //             ),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),

                        //----------------Most Recent View Section---------------------------//
                        const SizedBox(height: 20),
                        FutureBuilder<PromoResponse>(
                          future: _future,
                          builder: (context, snapshott) {
                            if (snapshott.hasData) {
                              List<Widget> children = [];
                              var data = snapshott.data!.carosuel;
                              for (int indexx = 1;
                                  indexx < data.length;
                                  indexx++) {
                                var element = snapshott.data!.carosuel[indexx];
                                DateTime dateTime = DateTime.parse(
                                    snapshott.data!.carosuel[indexx].createdAt);
                                DateTime updatedAt = DateTime.parse(
                                    snapshott.data!.carosuel[indexx].updatedAt);
                                print(dateTime);
                                if (indexx == 2) {
                                  children.add(Column(
                                    children: [
                                      Container(
                                        height: h * .22,
                                        // width: w * .7,

                                        margin: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        decoration: BoxDecoration(
                                            // color: Colors.amber,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    "https://urbanmalta.com/public/uploads/banners/${snapshott.data!.banners[0].image}")),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Container(
                                          height: h * .22,
                                          // width: w * .7,
                                          decoration: BoxDecoration(
                                              color: AppColors.app_color
                                                  .withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(width: w * 0.05),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${snapshott.data!.banners[0].title}",
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: h * .02,
                                                  ),
                                                  Text(
                                                    "${snapshott.data!.banners[0].desc}",
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12),
                                                  ),
                                                  SizedBox(
                                                    height: h * .02,
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      pushDynamicScreen(context,
                                                          screen:
                                                              ProviderOffersFromHomePage(
                                                                  serviceid:
                                                                      snapshott
                                                                          .data!
                                                                          .banners[
                                                                              0]
                                                                          .id,
                                                                  name: snapshott
                                                                      .data!
                                                                      .banners[0]
                                                                      .title,
                                                                  desc: snapshott
                                                                      .data!
                                                                      .banners[0]
                                                                      .desc,
                                                                  lat: latitude,
                                                                  lng: longitude),
                                                          withNavBar: false);
                                                      /*pushDynamicScreen(context,
                                                   screen:
                                                   withNavBar: false);*/
                                                    },
                                                    child: Container(
                                                      height: h * .05,
                                                      width: w * .15,
                                                      decoration: BoxDecoration(
                                                          color: Colors.black,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30)),
                                                      child: const Center(
                                                        child: Text(
                                                          "Book Now",
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              fontSize: 10),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ));
                                } else if (indexx == 4) {
                                  if (snapshott.data!.banners.length > 0) {
                                    children.add(InkWell(
                                      onTap: () {},
                                      child: Column(
                                        children: [
                                          Container(
                                            height: h * .21,
                                            width: w,
                                            margin: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            decoration: BoxDecoration(
                                                color: const Color(0xff4995EB),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child:
                                                Padding(
                                                  padding:  EdgeInsets.symmetric(horizontal: w*.05),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "${snapshott.data!.promocode[0].title}",
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                      SizedBox(
                                                        height: h * .01,
                                                      ),
                                                      Container(
                                                        height: h * .045,
                                                        // width: w * .4,

                                                        child: Text(
                                                          "${snapshott.data!.promocode[0].desc}",
                                                          style: const TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 9),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: h * .02,
                                                      ),
                                                      InkWell(
                                                        onTap: () {},
                                                        child: Container(
                                                          height: h * .05,
                                                          width: w * .18,
                                                          padding:
                                                              const EdgeInsets.only(
                                                                  left: 15,
                                                                  right: 10),
                                                          decoration: BoxDecoration(
                                                              color: Colors.black,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30)),
                                                          child: InkWell(
                                                            onTap: () {
                                                              pushDynamicScreen(
                                                                  context,
                                                                  screen: ProviderOffersFromHomePage(
                                                                      serviceid:
                                                                          snapshott
                                                                              .data!
                                                                              .promocode[
                                                                                  0]
                                                                              .id!,
                                                                      name: snapshott
                                                                          .data!
                                                                          .promocode[
                                                                              0]
                                                                          .title!,
                                                                      desc: snapshott
                                                                          .data!
                                                                          .promocode[
                                                                              0]
                                                                          .desc,
                                                                      lat: latitude,
                                                                      lng:
                                                                          longitude),
                                                                  withNavBar:
                                                                      false);
                                                            },
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Text(
                                                                  "${snapshott.data!.promocode[0].status}",
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize: 10),
                                                                ),
                                                                Container(
                                                                  height: h * .03,
                                                                  width: w * .04,
                                                                  // margin: EdgeInsets.all(5),
                                                                  // padding: EdgeInsets.all(),
                                                                  decoration: const BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      shape: BoxShape
                                                                          .circle),
                                                                  child: const Icon(
                                                                    Icons
                                                                        .arrow_forward_ios,
                                                                    color: Color(
                                                                        0xff4995EB),
                                                                    size: 13,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ));
                                  } else {
                                    children.add(Container());
                                  }
                                }
                                if (element.services.length > 0 &&
                                    element.services.any((service) =>
                                        service.gigDocument.isNotEmpty &&
                                        service
                                            .gigDocument[0].fileName.isNotEmpty &&
                                        service.title.isNotEmpty)) {
                                  children.add(
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          height: h * .04,
                                          width: w * .3,
                                          // color: Colors.black,
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text("${element.heading}",
                                              style: TextStyle(
                                                  color: AppColors.app_color,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      ScreenUtil().setSp(18))),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: h * .20,
                                          width: w * .85,
                                          child: ListView.builder(
                                            itemCount: element.services.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              DateTime datettime = DateTime.parse(
                                                  snapshott
                                                      .data!
                                                      .carosuel[indexx]
                                                      .services[index]
                                                      .servicePackages!
                                                      .createdAt);
                                              DateTime updated = DateTime.parse(
                                                  snapshott
                                                      .data!
                                                      .carosuel[indexx]
                                                      .services[index]
                                                      .servicePackages!
                                                      .updatedAt);

                                              List<Gigdocument> gigdoc = [];
                                              Servicepackages sp = Servicepackages(
                                                  id: snapshott
                                                      .data!
                                                      .carosuel[indexx]
                                                      .services[index]
                                                      .servicePackages
                                                      ?.id,
                                                  description: snapshott
                                                      .data!
                                                      .carosuel[indexx]
                                                      .services[index]
                                                      .servicePackages
                                                      ?.description,
                                                  title: snapshott
                                                      .data!
                                                      .carosuel[indexx]
                                                      .services[index]
                                                      .servicePackages
                                                      ?.title,
                                                  createdAt: datettime,
                                                  extraForUrgentNeed: snapshott
                                                      .data!
                                                      .carosuel[indexx]
                                                      .services[index]
                                                      .servicePackages
                                                      ?.extraForUrgentNeed,
                                                  location: snapshott
                                                      .data!
                                                      .carosuel[indexx]
                                                      .services[index]
                                                      .servicePackages
                                                      ?.location,
                                                  price: snapshott
                                                      .data!
                                                      .carosuel[indexx]
                                                      .services[index]
                                                      .servicePackages
                                                      ?.price,
                                                  serviceId: snapshott
                                                      .data!
                                                      .carosuel[indexx]
                                                      .services[index]
                                                      .servicePackages
                                                      ?.serviceId,
                                                  updatedAt: updated);
                                              snapshott.data!.carosuel[indexx]
                                                  .services[index].gigDocument
                                                  .forEach((elementt) {
                                                gigdoc.add(Gigdocument(
                                                    id: elementt.id,
                                                    serviceid: elementt.serviceId,
                                                    fileType: elementt.fileType,
                                                    fileName: elementt.fileName,
                                                    userid: elementt.userId));
                                              });
                                              RecommendedServiceProvidersResponse
                                                  response =
                                                  RecommendedServiceProvidersResponse(
                                                      categoryId: int.parse(
                                                          snapshott
                                                              .data!
                                                              .carosuel[indexx]
                                                              .categoryId),
                                                      createdAt: dateTime,
                                                      title: snapshott
                                                          .data!
                                                          .carosuel[indexx]
                                                          .services[index]
                                                          .title,
                                                      id: snapshott
                                                          .data!
                                                          .carosuel[indexx]
                                                          .services[index]
                                                          .id,
                                                      description: snapshott
                                                          .data!
                                                          .carosuel[indexx]
                                                          .services[index]
                                                          .description,
                                                      gigdocument: gigdoc,
                                                      isDeleted: false,
                                                      isPaused: false,
                                                      rating: 5,
                                                      ratingCount: 5,
                                                      reviewCount: 5,
                                                      servicepackages: sp,
                                                      updatedAt: updatedAt,
                                                      slug: snapshott
                                                          .data!
                                                          .carosuel[indexx]
                                                          .services[index]
                                                          .slug,
                                                      userData: snapshott
                                                          .data!
                                                          .carosuel[indexx]
                                                          .services[index]
                                                          .userData,
                                                      userId: snapshott
                                                          .data!
                                                          .carosuel[indexx]
                                                          .services[index]
                                                          .userId);
                                              bool shouldShowItem = element
                                                      .services[index]
                                                      .gigDocument
                                                      .isNotEmpty &&
                                                  element
                                                      .services[index]
                                                      .gigDocument[0]
                                                      .fileName
                                                      .isNotEmpty;
                                              if (shouldShowItem) {
                                                return InkWell(
                                                  onTap: () async {
                                                    SharedPreferences prefs =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    String? addres =
                                                        prefs.getString(
                                                            'currentLocation');
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                      builder: (context) {
                                                        return ProviderDetailScreen(
                                                          id: response.id!,
                                                          location:
                                                              addres ?? 'Malta',
                                                        );
                                                      },
                                                    ));
                                                  },
                                                  child: Container(
                                                    height: h * .20,
                                                    width: w * .19,
                                                    clipBehavior: Clip.antiAlias,
                                                    margin: const EdgeInsets.only(
                                                        left: 5,
                                                        right: 5,
                                                        bottom: 5),
                                                    decoration: BoxDecoration(
                                                        boxShadow: [
                                                          const BoxShadow(
                                                            color: Colors.black12,
                                                            offset: Offset(
                                                              1.3,
                                                              1.3,
                                                            ), //Offset
                                                            blurRadius: 1.0,
                                                            spreadRadius: 1.0,
                                                          ),
                                                        ],
                                                        color: Colors.black,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10)),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          height: h * .13,
                                                          width: w,
                                                          // color: Colors.blue,
                                                          child: Image.network(
                                                            "https://urbanmalta.com/public/users/user_${element.services[index]?.gigDocument[0]?.userId}/documents/${element.services[index]?.gigDocument[0]?.fileName}",
                                                            fit: BoxFit.cover,

                                                            // "https://urbanmalta.com/public/users/user_${element.services[index].userId}/documents/${element.services[index]?.gigDocument[0]?.fileName}",
                                                            // fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                        Expanded(
                                                            child: Container(
                                                                height: h,
                                                                width: w,
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left: 2,
                                                                        right: 2),
                                                                color:
                                                                    Colors.white,
                                                                child: Center(
                                                                    child: Text(
                                                                  "${element.services[index].title}",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    color: AppColors
                                                                        .text_desc,
                                                                    fontSize:
                                                                        ScreenUtil()
                                                                            .setSp(
                                                                                12),
                                                                    // fontFamily:
                                                                    // "Montserrat-bold",
                                                                  ),
                                                                ))))
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }
                                              // else {
                                              //   return SizedBox.shrink();
                                              // }
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }
                              return Container(
                                // color: Colors.amber,
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),

                                    ...children,

                                    const SizedBox(
                                      height: 20,
                                    ),

                                    // SizedBox(
                                    //   height: h * .02,
                                    // ),
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.end,
                                    //   children: [
                                    //     Container(
                                    //       height: h * .04,
                                    //       width: w * .14,
                                    //       // color: Colors.amber,
                                    //       margin: EdgeInsets.only(left: 2, right: 2),
                                    //       child: Row(
                                    //         children: [
                                    //           Material(
                                    //             color: Colors.transparent,
                                    //             child: InkWell(
                                    //               splashColor: Colors.white,
                                    //               onTap: () {},
                                    //               child: Container(
                                    //                   height: h * .03,
                                    //                   width: w * .06,
                                    //                   // color: Colors.blue,
                                    //                   child: Center(
                                    //                       // child: Text(
                                    //                       //   "View All",
                                    //                       //   style: TextStyle(
                                    //                       //       color: Color(0xff4995EB),
                                    //                       //       fontSize: 11),
                                    //                       // ),
                                    //                       )),
                                    //             ),
                                    //           ),
                                    //           Container(
                                    //             height: h * .03,
                                    //             width: w * .07,
                                    //             // margin: EdgeInsets.all(5),
                                    //             // padding: EdgeInsets.all(),
                                    //             decoration: BoxDecoration(
                                    //                 color: Colors.white,
                                    //                 shape: BoxShape.circle),
                                    //             child: Icon(
                                    //               Icons.arrow_forward_ios,
                                    //               color: Color(0xff4995EB),
                                    //               size: 13,
                                    //             ),
                                    //           )
                                    //         ],
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                  ],
                                ),
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),

                        //----------------------------------Book Now Section-------------------------------------//

                        SizedBox(
                          height: h * .03,
                        ),
                        //------------------------------Hair Dresses Section-------------------//
                        /* Container(
                          height: h * .32,
                          width: w,
                          // color: Colors.amber,
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: h * .04,
                                width: w,
                                // color: Colors.black,
                                padding: EdgeInsets.only(left: 6),
                                child: Text("Hair Dresser For Men",
                                    style: TextStyle(
                                        color: AppColors.app_color,
                                        fontWeight: FontWeight.bold,
                                        fontSize: ScreenUtil().setSp(18))),
                              ),
                              SizedBox(
                                height: h * .02,
                              ),
                              Container(
                                height: h * .21,
                                width: w * .85,
                                child: ListView.builder(
                                  itemCount: 7,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: h * .21,
                                      width: w * .195,
                                      clipBehavior: Clip.antiAlias,
                                      margin: const EdgeInsets.only(
                                          left: 5, right: 5, bottom: 5),
                                      decoration: BoxDecoration(
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black12,
                                              offset: Offset(
                                                1.3,
                                                1.3,
                                              ), //Offset
                                              blurRadius: 1.0,
                                              spreadRadius: 1.0,
                                            ),
                                          ],
                                          // color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: h * .13,
                                            width: w,
                                            // color: Colors.blue,
                                            child: Image.asset(
                                              "assets/images/Dresser.png",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: h,
                                              width: w,
                                              color: Colors.white,
                                              padding: EdgeInsets.only(
                                                left: 5,
                                                top: 3,
                                                bottom: 2,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        height: h * .02,
                                                        width: w * .1,
                                                        // color: Colors.amber,
                                                        child: Text("John Carter",
                                                            style: TextStyle(
                                                              // color: AppColors
                                                              //     .text_desc,
                                                              color: Colors.black,
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(11),
                                                              fontFamily:
                                                                  "Montserrat-bold",
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                            )),
                                                      ),
                                                      SizedBox(
                                                        width: w * .02,
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                        size: 12,
                                                      ),
                                                      // SizedBox(
                                                      //   width: w * .01,
                                                      // ),
                                                      Container(
                                                        height: h * .027,
                                                        width: w * .035,
                                                        // color: Colors.red,
                                                        child: Center(
                                                          child: Text(
                                                            "4.5",
                                                            style: TextStyle(
                                                                fontSize: 11,
                                                                color:
                                                                    Colors.amber),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: h * .01,
                                                  ),
                                                  Text("Hair Dresser",
                                                      style: TextStyle(
                                                        // color: Colors.black,
                                                        // fontSize: 10,
                                                        color:
                                                            AppColors.text_desc,
                                                        fontSize:
                                                            ScreenUtil().setSp(9),
                                                        fontFamily:
                                                            "Montserrat-bold",
                                                      )),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              //   SizedBox(
                              // height: h * .01,
                              //   ),
                              //   Row(
                              //     mainAxisAlignment: MainAxisAlignment.end,
                              //     children: [
                              //       Container(
                              //         height: h * .04,
                              //         width: w * .14,
                              //         // color: Colors.amber,
                              //         margin: EdgeInsets.only(left: 2, right: 2),
                              //         child: Row(
                              //           children: [
                              //             Material(
                              //               color: Colors.transparent,
                              //               child: InkWell(
                              //                 splashColor: Colors.white,
                              //                 onTap: () {},
                              //                 child: Container(
                              //                     height: h * .03,
                              //                     width: w * .066,
                              //                     // color: Colors.blue,
                              //                     child: Center(
                              //                         // child: Text(
                              //                         //   "View All",
                              //                         //   style: TextStyle(
                              //                         //       color:
                              //                         //           AppColors.app_color,
                              //                         //       fontSize: 11),
                              //                         // ),
                              //                         )),
                              //               ),
                              //             ),
                              //             Container(
                              //               height: h * .03,
                              //               width: w * .07,
                              //               // margin: EdgeInsets.all(5),
                              //               // padding: EdgeInsets.all(),
                              //               decoration: BoxDecoration(
                              //                   color: Colors.white,
                              //                   shape: BoxShape.circle),
                              //               child: Icon(
                              //                 Icons.arrow_forward_ios,
                              //                 color: Color(0xff4995EB),
                              //                 size: 13,
                              //               ),
                              //             )
                              //           ],
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // //
                            ],
                          ),
                        ),
                        SizedBox(
                          height: h * .01,
                        ),
                        //-----------------------------New House Section-----------------------------//
                        Container(
                          height: h * .32,
                          width: w,
                          // color: Colors.amber,
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: h * .04,
                                width: w,
                                // color: Colors.black,
                                padding: EdgeInsets.only(left: 6),
                                child: Text("New In the House ",
                                    style: TextStyle(
                                        color: AppColors.app_color,
                                        fontWeight: FontWeight.bold,
                                        fontSize: ScreenUtil().setSp(18))),
                              ),
                              SizedBox(
                                height: h * .02,
                              ),
                              Container(
                                height: h * .20,
                                width: w * .85,
                                child: ListView.builder(
                                  itemCount: 7,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: h * .20,
                                      width: w * .19,
                                      clipBehavior: Clip.antiAlias,
                                      margin: const EdgeInsets.only(
                                          left: 5, right: 5, bottom: 5),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              offset: Offset(
                                                1.3,
                                                1.3,
                                              ), //Offset
                                              blurRadius: 1.0,
                                              spreadRadius: 1.0,
                                            ),
                                          ],
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: h * .13,
                                            width: w,
                                            // color: Colors.blue,
                                            child: Image.asset(
                                              "assets/images/doct.png",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Expanded(
                                              child: Container(
                                                  height: h,
                                                  width: w,
                                                  padding: EdgeInsets.only(
                                                      left: 2, right: 2),
                                                  color: Colors.white,
                                                  child: Center(
                                                      child: Text(
                                                    "Doctor",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: AppColors.text_desc,
                                                      fontSize:
                                                          ScreenUtil().setSp(12),
                                                      fontFamily:
                                                          "Montserrat-bold",
                                                    ),
                                                  ))))
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              // SizedBox(
                              //   height: h * .02,
                              // ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.end,
                              //   children: [
                              //     Container(
                              //       height: h * .04,
                              //       width: w * .14,
                              //       // color: Colors.amber,
                              //       margin: EdgeInsets.only(left: 2, right: 2),
                              //       child: Row(
                              //         children: [
                              //           Material(
                              //             color: Colors.transparent,
                              //             child: InkWell(
                              //               splashColor: Colors.white,
                              //               onTap: () {},
                              //               child: Container(
                              //                   height: h * .03,
                              //                   width: w * .066,
                              //                   // color: Colors.blue,
                              //                   child: Center(
                              //                       // child: Text(
                              //                       //   "View All",
                              //                       //   style: TextStyle(
                              //                       //       color:
                              //                       //           AppColors.app_color,
                              //                       //       fontSize: 11),
                              //                       // ),
                              //                       )),
                              //             ),
                              //           ),
                              //           Container(
                              //             height: h * .03,
                              //             width: w * .07,
                              //             // margin: EdgeInsets.all(5),
                              //             // padding: EdgeInsets.all(),
                              //             decoration: BoxDecoration(
                              //                 color: Colors.white,
                              //                 shape: BoxShape.circle),
                              //             child: Icon(
                              //               Icons.arrow_forward_ios,
                              //               color: Color(0xff4995EB),
                              //               size: 13,
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                        //////----------------------Invite friend section---------///////////
                        SizedBox(
                          height: h * .01,
                        ),*/

                        /*  FutureBuilder<PromoResponse>(
                            future: _future,
                            builder: (context, response) {
                              print('printing Presponse ${response.data?.banners.toString()}' );

                              if (response.connectionState != ConnectionState.done) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if(response.data!.banners.length>0) {
                                return    Container(
                                  height: h * .21,
                                  width: w,
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  decoration: BoxDecoration(
                                      color: Color(0xff4995EB),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(width: w * 0.05),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${response.data!.promocode[0].title}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: h * .01,
                                          ),
                                          Container(
                                            height: h * .045,
                                            // width: w * .4,

                                            child: Text(
                                              "${response.data!.promocode[0].desc}",
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 9),
                                            ),
                                          ),
                                          SizedBox(
                                            height: h * .02,
                                          ),
                                          InkWell(
                                            onTap: () {},
                                            child: Container(
                                              height: h * .05,
                                              width: w * .18,
                                              padding:
                                              EdgeInsets.only(left: 15, right: 10),
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                  BorderRadius.circular(30)),
                                              child: InkWell(
                                                onTap: () {

                                                  pushDynamicScreen(context,
                                                      screen: ProviderOffersFromHomePage(
                                                          serviceid: response.data!.promocode[0].id!,
                                                          name: response.data!.promocode[0].title!,
                                                          desc: response.data!.promocode[0].desc),
                                                      withNavBar: false);

                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Text(
                                                      "${response.data!.promocode[0].status}",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 10),
                                                    ),
                                                    Container(
                                                      height: h * .03,
                                                      width: w * .04,
                                                      // margin: EdgeInsets.all(5),
                                                      // padding: EdgeInsets.all(),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          shape: BoxShape.circle),
                                                      child: Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: Color(0xff4995EB),
                                                        size: 13,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              }else{
                                return Container();
                              }
                            }),
                        SizedBox(height: h * .03),*/

                        ///------------------------------Top Rated Services---------------////////
                        /*  Container(
                          height: h * .32,
                          width: w,
                          // color: Colors.amber,
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: h * .04,
                                width: w,
                                // color: Colors.black,
                                padding: EdgeInsets.only(left: 6),
                                child: Text("Top Rated Services",
                                    style: TextStyle(
                                        color: AppColors.app_color,
                                        fontWeight: FontWeight.bold,
                                        fontSize: ScreenUtil().setSp(18))),
                              ),
                              SizedBox(
                                height: h * .02,
                              ),
                              Container(
                                height: h * .20,
                                width: w * .85,
                                child: ListView.builder(
                                  itemCount: 7,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: h * .20,
                                      width: w * .19,
                                      clipBehavior: Clip.antiAlias,
                                      margin: const EdgeInsets.only(
                                          left: 5, right: 5, bottom: 5),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              offset: Offset(
                                                1.3,
                                                1.3,
                                              ), //Offset
                                              blurRadius: 1.0,
                                              spreadRadius: 1.0,
                                            ),
                                          ],
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: h * .13,
                                            width: w,
                                            // color: Colors.blue,
                                            child: Image.asset(
                                              "assets/images/clean.png",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Expanded(
                                              child: Container(
                                                  height: h,
                                                  width: w,
                                                  padding: EdgeInsets.only(
                                                      left: 2, right: 2),
                                                  color: Colors.white,
                                                  child: Center(
                                                      child: Text(
                                                    "Office Cleaning",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: AppColors.text_desc,
                                                      fontSize:
                                                          ScreenUtil().setSp(12),
                                                      fontFamily:
                                                          "Montserrat-bold",
                                                    ),
                                                  ))))
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              // SizedBox(
                              //   height: h * .02,
                              // ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.end,
                              //   children: [
                              //     Container(
                              //       height: h * .04,
                              //       width: w * .14,
                              //       // color: Colors.amber,
                              //       margin: EdgeInsets.only(left: 2, right: 2),
                              //       child: Row(
                              //         children: [
                              //           Material(
                              //             color: Colors.transparent,
                              //             child: InkWell(
                              //               splashColor: Colors.white,
                              //               onTap: () {},
                              //               child: Container(
                              //                   height: h * .03,
                              //                   width: w * .066,
                              //                   // color: Colors.blue,
                              //                   child: Center(
                              //                       // child: Text(
                              //                       //   "View All",
                              //                       //   style: TextStyle(
                              //                       //       color:
                              //                       //           AppColors.app_color,
                              //                       //       fontSize: 11),
                              //                       // ),
                              //                       )),
                              //             ),
                              //           ),
                              //           Container(
                              //             height: h * .03,
                              //             width: w * .07,
                              //             // margin: EdgeInsets.all(5),
                              //             // padding: EdgeInsets.all(),
                              //             decoration: BoxDecoration(
                              //                 color: Colors.white,
                              //                 shape: BoxShape.circle),
                              //             child: Icon(
                              //               Icons.arrow_forward_ios,
                              //               color: Color(0xff4995EB),
                              //               size: 13,
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                        SizedBox(height: h * .01),
                        //-----------------AC Rapir Section-------------------///////////
                        Container(
                          height: h * .32,
                          width: w,
                          // color: Colors.amber,
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: h * .04,
                                width: w,
                                padding: EdgeInsets.only(left: 6),
                                // color: Colors.black,
                                child: Text("AC & Appliance Repair",
                                    style: TextStyle(
                                        color: AppColors.app_color,
                                        fontWeight: FontWeight.bold,
                                        fontSize: ScreenUtil().setSp(18))),
                              ),
                              SizedBox(
                                height: h * .02,
                              ),
                              Container(
                                height: h * .20,
                                width: w * .85,
                                child: ListView.builder(
                                  itemCount: 7,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: h * .20,
                                      width: w * .19,
                                      clipBehavior: Clip.antiAlias,
                                      margin: const EdgeInsets.only(
                                          left: 5, right: 5, bottom: 5),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              offset: Offset(
                                                1.3,
                                                1.3,
                                              ), //Offset
                                              blurRadius: 1.0,
                                              spreadRadius: 1.0,
                                            ),
                                          ],
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: h * .13,
                                            width: w,
                                            // color: Colors.blue,
                                            child: Image.asset(
                                              "assets/images/acrepair.png",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Expanded(
                                              child: Container(
                                                  height: h,
                                                  width: w,
                                                  padding: EdgeInsets.only(
                                                      left: 2, right: 2),
                                                  alignment: Alignment.center,
                                                  color: Colors.white,
                                                  child: Text(
                                                    "Ac Services And  Repair",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: AppColors.text_desc,
                                                      fontSize:
                                                          ScreenUtil().setSp(12),
                                                      fontFamily:
                                                          "Montserrat-bold",
                                                    ),
                                                  )))
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: h * .02,
                              ),
                              //   Row(
                              //     mainAxisAlignment: MainAxisAlignment.end,
                              //     children: [
                              //       Container(
                              //         height: h * .04,
                              //         width: w * .14,
                              //         // color: Colors.amber,
                              //         margin: EdgeInsets.only(left: 2, right: 2),
                              //         child: Row(
                              //           children: [
                              //             Material(
                              //               color: Colors.transparent,
                              //               child: InkWell(
                              //                 splashColor: Colors.white,
                              //                 onTap: () {},
                              //                 child: Container(
                              //                     height: h * .03,
                              //                     width: w * .066,
                              //                     // color: Colors.blue,
                              //                     child: Center(
                              //                         // child: Text(
                              //                         //   "View All",
                              //                         //   style: TextStyle(
                              //                         //       color:
                              //                         //           AppColors.app_color,
                              //                         //       fontSize: 11),
                              //                         // ),
                              //                         )),
                              //               ),
                              //             ),
                              //             Container(
                              //               height: h * .03,
                              //               width: w * .07,
                              //               // margin: EdgeInsets.all(5),
                              //               // padding: EdgeInsets.all(),
                              //               decoration: BoxDecoration(
                              //                   color: Colors.white,
                              //                   shape: BoxShape.circle),
                              //               child: Icon(
                              //                 Icons.arrow_forward_ios,
                              //                 color: Color(0xff4995EB),
                              //                 size: 13,
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                            ],
                          ),
                        ),
                        SizedBox(height: h * .01),
                        //-------------------Cleaning Service Section---------------////////
                        Container(
                          height: h * .32,
                          width: w,
                          // color: Colors.amber,
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: h * .04,
                                width: w,
                                // color: Colors.black,
                                padding: EdgeInsets.only(left: 6),
                                child: Text("Cleaning Service",
                                    style: TextStyle(
                                        color: AppColors.app_color,
                                        fontWeight: FontWeight.bold,
                                        fontSize: ScreenUtil().setSp(18))),
                              ),
                              SizedBox(
                                height: h * .02,
                              ),
                              Container(
                                height: h * .20,
                                width: w * .85,
                                child: ListView.builder(
                                  itemCount: 7,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: h * .20,
                                      width: w * .19,
                                      clipBehavior: Clip.antiAlias,
                                      margin: const EdgeInsets.only(
                                          left: 5, right: 5, bottom: 5),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              offset: Offset(
                                                1.3,
                                                1.3,
                                              ), //Offset
                                              blurRadius: 1.0,
                                              spreadRadius: 1.0,
                                            ),
                                          ],
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: h * .13,
                                            width: w,
                                            // color: Colors.blue,
                                            child: Image.asset(
                                              "assets/images/swiper.png",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Expanded(
                                              child: Container(
                                                  height: h,
                                                  width: w,
                                                  padding: EdgeInsets.only(
                                                      left: 2, right: 2),
                                                  color: Colors.white,
                                                  child: Center(
                                                      child: Text(
                                                    "Home Cleaning",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: AppColors.text_desc,
                                                      fontSize:
                                                          ScreenUtil().setSp(12),
                                                      fontFamily:
                                                          "Montserrat-bold",
                                                    ),
                                                  ))))
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: h * .02,
                              ),
                              //   Row(
                              //     mainAxisAlignment: MainAxisAlignment.end,
                              //     children: [
                              //       Container(
                              //         height: h * .04,
                              //         width: w * .14,
                              //         // color: Colors.amber,
                              //         margin: EdgeInsets.only(left: 2, right: 2),
                              //         child: Row(
                              //           children: [
                              //             Material(
                              //               color: Colors.transparent,
                              //               child: InkWell(
                              //                 splashColor: Colors.white,
                              //                 onTap: () {},
                              //                 child: Container(
                              //                     height: h * .03,
                              //                     width: w * .066,
                              //                     // color: Colors.blue,
                              //                     child: Center(
                              //                         // child: Text(
                              //                         //   "View All",
                              //                         //   style: TextStyle(
                              //                         //       color:
                              //                         //           AppColors.app_color,
                              //                         //       fontSize: 11),
                              //                         // ),
                              //                         )),
                              //               ),
                              //             ),
                              //             Container(
                              //               height: h * .03,
                              //               width: w * .07,
                              //               // margin: EdgeInsets.all(5),
                              //               // padding: EdgeInsets.all(),
                              //               decoration: BoxDecoration(
                              //                   color: Colors.white,
                              //                   shape: BoxShape.circle),
                              //               child: Icon(
                              //                 Icons.arrow_forward_ios,
                              //                 color: Color(0xff4995EB),
                              //                 size: 13,
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                            ],
                          ),
                        ),*/
                      ],
                    )),
              )),
            ],
          ),
        ),
      ),
    );
  }

  bottomSheetForSignIn(BuildContext context) {
    showModalBottomSheet(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height - 50),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: LoginScreen(isFromOtherScreen: true));
        }).whenComplete(() {
      print('ondismiss');
      if (StorageManager().accessToken.isNotNullAndNotEmpty)
        pushDynamicScreen(context,
            screen: SettingsRoutePage(), withNavBar: false);
    });
  }
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'Press again to exit the app!',backgroundColor: Colors.blueAccent);

      return Future.value(false);
    }
    return Future.value(true);
  }
}

