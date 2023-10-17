import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../models/serializable_model/PopularServiceListResponse.dart';
import '../../slider_offers.dart';

class OurBestServices extends StatefulWidget {
  final Future<List<PopularServiceListResponse>> futureData;
  final double lat;
  final double lng;

  const OurBestServices(
      {Key? key,
      required this.futureData,
      required this.lat,
      required this.lng})
      : super(key: key);

  @override
  _OurBestServicesState createState() => _OurBestServicesState();
}

class _OurBestServicesState extends State<OurBestServices> {
  // late final Future<List<PopularServiceListResponse>> futureData;

  // @override
  // void initState() {
  //   super.initState();
  //   // futureData = HttpClient().getPopularServices();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Column(
            children: [
              SizedBox(
                height: 180,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 16, 8),
                    child: FutureBuilder(
                        future: widget.futureData,
                        builder: (context,
                            AsyncSnapshot<List<PopularServiceListResponse>>
                                response) {
                          if (response.connectionState !=
                              ConnectionState.done) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ListView(
                              scrollDirection: Axis.horizontal,
                              physics: const ScrollPhysics(),
                              children: response.data!
                                  .map((item) => Padding(
                                        padding:
                                            const EdgeInsets.only(left: 4.0),
                                        child: Card(
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.6,
                                            height: 140,
                                            child: InkWell(
                                              onTap: () => {
                                                pushDynamicScreen(context,
                                                    screen:
                                                        ProviderOffersFromHomePage(
                                                            serviceid: item.id!,
                                                            name: item.name!,
                                                            desc:
                                                                "item.description",
                                                            lat: widget.lat,
                                                            lng: widget.lng),
                                                    withNavBar: false)
                                              },
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center, // add this
                                                children: <Widget>[
                                                  Expanded(
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                              topLeft: Radius
                                                                  .circular(8),
                                                              topRight: Radius
                                                                  .circular(8)),
                                                      child: getImage(item
                                                          .service_cat_icon!),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.all(12),
                                                    child: Text(
                                                      item.name!,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color:
                                                            AppColors.text_desc,
                                                        fontSize: ScreenUtil()
                                                            .setSp(12),
                                                        // fontFamily: "Montserrat-bold",
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ))
                                  .toList());
                        })),
              ),
            ],
          ),
        )
      ],
    );
  }

  getImage(String image) {
    print('printing image ${image}');
    return Image.network(
        "https://urbanmalta.com/public/uploads/servicecategory/icons/$image",
        fit: BoxFit.cover);
  }
}
