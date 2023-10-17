import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/models/serializable_model/TrendingServicesResponse.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../models/promo_model.dart';
import '../../ProviderScreens/provider_detail.dart';
import '../../slider_offers.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({Key? key, required this.lat, required this.lng})
      : super(key: key);
  final double lat;
  final double lng;

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Future<PromoResponse>? _future;

  @override
  void initState() {
    _future = fetchData();
    super.initState();
  }

  Future<PromoResponse> fetchData() async {
    final url =
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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
        child: FutureBuilder<PromoResponse>(
            future: _future,
            builder: (context, response) {
              print('printing Presponse ${response.data?.banners.toString()}');

              if (response.connectionState != ConnectionState.done) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (response.data?.banners != null &&
                  response.data!.banners.isNotEmpty) {
                return CarouselSlider(
                  options: CarouselOptions(
                      autoPlay: true,
                      autoPlayCurve: Curves.easeInOutBack,
                      autoPlayInterval: const Duration(seconds: 3)),
                  items: response.data?.banners
                      .map((item) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: GestureDetector(
                            onTap: () {
                              pushDynamicScreen(context,
                                  screen: ProviderOffersFromHomePage(
                                      serviceid: item.id!,
                                      name: item.title!,
                                      desc: item.desc,
                                      lat: widget.lat,
                                      lng: widget.lng),
                                  withNavBar: false);
                            },
                            child: Stack(
                              children: [
                                Container(
                                    height: ScreenUtil().setHeight(170),
                                    decoration: BoxDecoration(
                                      color: const Color(0xff7c94b6),
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          colorFilter: ColorFilter.mode(
                                              Colors.black.withOpacity(0.4),
                                              BlendMode.darken),
                                          image: NetworkImage(
                                              'https://urbanmalta.com/public/uploads/banners/${item.image}')),
                                    )),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(10),
                                    top: ScreenUtil().setHeight(20),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.title,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: ScreenUtil().setSp(18),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          item.status,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: ScreenUtil().setSp(16),
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      SizedBox(
                                        height: ScreenUtil().setHeight(50),
                                      ),
                                      // Container(
                                      //   height: ScreenUtil().setHeight(28),
                                      //   width: ScreenUtil().setWidth(90),
                                      //   decoration: BoxDecoration(
                                      //       borderRadius: BorderRadius.circular(10),
                                      //       color: Colors.blue),
                                      //   child: Center(
                                      //     child: Text(
                                      //       'Book Now',
                                      //       style: TextStyle(
                                      //           color: Colors.white,
                                      //           fontWeight: FontWeight.bold,
                                      //           fontSize: ScreenUtil().setSp(13)),
                                      //     ),
                                      //   ),
                                      // ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 25,
                                            right: 15,
                                            top: 5,
                                            bottom: 5),
                                        width: 160,
                                        alignment: Alignment.center,
                                        child: TextButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    AppColors.app_color),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Book Now",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  // fontFamily: 'Montserrat-bold',
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Image.asset(
                                                  'assets/icons/arw.png',
                                                  scale: 2,
                                                  fit: BoxFit.cover),
                                            ],
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProviderDetailScreen(
                                                            id: item.id)));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )))
                      .toList(),
                );
              } else {
                return Container();
              }
            }));
  }

  getImage(TrendingServicesResponse item) {
    if (item.gigdocument != null && item.gigdocument.length > 0) {
      return NetworkImage(
          "https://urbanmalta.com/public/users/user_${item.gigdocument[0].userid}/documents/${item.gigdocument[0].fileName}");
    } else {
      return AssetImage(
        'assets/images/bycyclemechenic.jpg',
      );
    }
  }
}
