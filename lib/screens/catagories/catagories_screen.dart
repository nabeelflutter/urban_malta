import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/net/http_client.dart';
import 'package:kappu/screens/slider_offers.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flutter/services.dart';
import '../../models/serializable_model/CategoryResponse.dart';
import 'package:kappu/main.dart';

class CatagoriesScreen extends StatefulWidget {
  const CatagoriesScreen({Key? key}) : super(key: key);

  @override
  _CatagoriesScreenState createState() => _CatagoriesScreenState();
}

class _CatagoriesScreenState extends State<CatagoriesScreen> {
  TextEditingController searchController = TextEditingController();
  String search = '';
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

  @override
  Widget build(BuildContext context) {
    _scaffoldContext = context;
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.red,
          statusBarIconBrightness: Brightness.dark),
    );
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.5,
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
            title: Text("Categories",
                style: TextStyle(
                  fontSize: 20.sp, color: Colors.black,
                  //  fontFamily: "Montserrat-Bold"
                )),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.search))
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Container(
                  padding: const EdgeInsets.only(left: 20),
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xfff8f9ff),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(19),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          size: 29,
                          color: Color(0xff8E98BD),
                        ),
                        hintText: "Search",
                        hintStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff8E98BD),
                        ),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          search = value.toString();
                        });
                      }),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: HttpClient().getCatagory(),
                  builder: (context, AsyncSnapshot<CategoryResponse> response) {
                    if (response.connectionState != ConnectionState.done) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final categories = response.data?.data ?? [];

                    if (searchController.text.isEmpty) {
                      return ListView.builder(
                        padding:
                            EdgeInsets.only(top: ScreenUtil().setHeight(12)),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final item = categories[index];
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  pushDynamicScreen(
                                    context,
                                    screen: ProviderOffersFromHomePage(
                                      serviceid: item.id,
                                      name: item.name,
                                      desc: item.description,
                                    ),
                                    withNavBar: false,
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(10),
                                        bottom: ScreenUtil().setHeight(8),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        child: Image.network(
                                          response.data!.baseUrl +
                                              "/" +
                                              item.image,
                                          width: 80,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            item.name,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: ScreenUtil().setSp(16),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              item.description,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize:
                                                    ScreenUtil().setSp(14),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 25,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: ScreenUtil().setWidth(40),
                                    )
                                  ],
                                ),
                              ),
                              const Divider(
                                thickness: 1,
                              )
                            ],
                          );
                        },
                      );
                    } else {
                      final filteredCategories = categories
                          .where((item) => item.name
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase()))
                          .toList();
                      return ListView.builder(
                        padding:
                            EdgeInsets.only(top: ScreenUtil().setHeight(12)),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: filteredCategories.length,
                        itemBuilder: (context, index) {
                          final item = filteredCategories[index];
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  pushDynamicScreen(
                                    context,
                                    screen: ProviderOffersFromHomePage(
                                      serviceid: item.id,
                                      name: item.name,
                                      desc: item.description,
                                    ),
                                    withNavBar: false,
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(10),
                                        bottom: ScreenUtil().setHeight(8),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        child: Image.network(
                                          response.data!.baseUrl +
                                              "/" +
                                              item.image,
                                          width: 80,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            item.name,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: ScreenUtil().setSp(16),
                                              // fontFamily: "Montserrat-Bold",
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              item.description,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize:
                                                    ScreenUtil().setSp(14),
                                                // fontFamily: "Montserrat-Regular",
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 25,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: ScreenUtil().setWidth(40),
                                    )
                                  ],
                                ),
                              ),
                              const Divider(
                                thickness: 1,
                              )
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

class CategoryRoutePage extends ModalRoute<void> {
  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => "";

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return const Material(
      type: MaterialType.transparency,
      // child: _buildOverlayContent(context, true),
    );
  }
}
