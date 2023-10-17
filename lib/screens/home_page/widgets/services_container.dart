import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/models/serializable_model/CategoryResponse.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../catagories/catagories_screen.dart';
import '../../slider_offers.dart';

class Servicescontainer extends StatefulWidget {
  final Future<CategoryResponse>? categoryData;
  final double lat;
  final double lng;

  const Servicescontainer(
      {Key? key, this.categoryData, required this.lat, required this.lng})
      : super(key: key);

  @override
  _ServicescontainerState createState() => _ServicescontainerState();
}

class _ServicescontainerState extends State<Servicescontainer> {
  // final Future<CategoryResponse>? categoryData;

  // @override
  // void initState() {
  //   super.initState();
  //   categoryData = HttpClient().getCatagory();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
            future: widget.categoryData,
            builder: (context, AsyncSnapshot<CategoryResponse> response) {
              if (response.connectionState != ConnectionState.done) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return GridView.count(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(
                      response.data!.data.length > 7
                          ? 8
                          : response.data!.data.length, (index) {
                    return Card(
                      color: Colors.white,
                      child: GestureDetector(
                        onTap: () {
                          print(index);
                          response.data!.data.length > 7 && index == 7
                              ? pushDynamicScreen(context,
                                  screen: CategoryRoutePage(),
                                  withNavBar: false)
                              : pushDynamicScreen(context,
                                  screen: ProviderOffersFromHomePage(
                                      serviceid: response.data!.data[index].id,
                                      name: response.data!.data[index].name,
                                      desc: response
                                          .data!.data[index].description,
                                      lat: widget.lat,
                                      lng: widget.lng),
                                  withNavBar: false);
                        },
                        child: Container(
                          height: ScreenUtil().setHeight(60),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: response.data!.data.length > 7 &&
                                        index == 7
                                    ? Image.asset(
                                        'assets/icons/ct-8.png',
                                        height: ScreenUtil().setHeight(30),
                                      )
                                    : Image.network(
                                        response.data!.baseUrl +
                                            "/" +
                                            response.data!.data[index].image,
                                        height: ScreenUtil().setHeight(30),
                                      ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 4.0, left: 3, right: 3),
                                child: Center(
                                  child: Text(
                                      response.data!.data.length > 7 &&
                                              index == 7
                                          ? "More"
                                          : response.data!.data[index].name,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: AppColors.text_desc,
                                        fontSize: ScreenUtil().setSp(10),
                                        // fontFamily: 'Montserrat-Bold',
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }));
            }));
  }
}
