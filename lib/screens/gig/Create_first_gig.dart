import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:kappu/models/serializable_model/CategoryResponse.dart';
import 'package:kappu/screens/ProviderScreens/dashboard/provider_home.dart';
import 'package:kappu/screens/Transaction/statisic.dart';
import 'package:kappu/screens/account/withdrow.dart';
import 'package:kappu/screens/gig/AddGig.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../components/AppColors.dart';
import '../../models/serializable_model/GigListResponse.dart';
import '../register/register_more.dart';
import 'Gig_tags.dart';
import 'gig_animation.dart';
import 'gig_description.dart';
import 'gig_title.dart';

class InputData {
  String? categoryId;
  String? title;
  List<String>? skills;
  String? desc;
  String? price;

  // Add more fields as needed

  InputData({this.categoryId, this.title, this.desc, this.price, this.skills});
  void setCategory(String value) {
    categoryId = value;
  }

  void setTitle(String value) {
    title = value;
  }

  void setSkills(List<String> value) {
    skills = value;
  }

  void setDesc(String value) {
    desc = value;
  }

  void setPrice(String value) {
    price = value;
  }
}

class FirstGigPage extends StatefulWidget {
  final Map<String, dynamic> bodyprovider;
  bool? isFromAddGig = false;
  bool? isFromEditGig = false;
  GigListResponse? myGig;
  FirstGigPage(
      {Key? key,
      required this.bodyprovider,
      this.isFromAddGig,
      this.isFromEditGig,
      this.myGig})
      : super(key: key);

  @override
  State<FirstGigPage> createState() => _FirstGigPageState();
}

class _FirstGigPageState extends State<FirstGigPage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int currentPageIndex = 0;
  PageController pageController = PageController();

  late InputData inputData;
  Map<String, dynamic> map = {};
  @override
  void initState() {
    super.initState();
    print(widget.myGig?.categoryId);
    inputData = InputData(
        title: widget.myGig?.title,
        categoryId: widget.myGig?.categoryId.toString(),
        desc: widget.myGig?.description,
        price: widget.myGig?.servicepackages?.price);

    // print();
  }

  void showValidationSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Please fill all details about your gig.',
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 3),
      ),
    );
  }

  Future<bool> onBackPressed() async {
    if (currentPageIndex > 0) {
      // Navigate to the first page if the user is not on the first page
      pageController.jumpToPage(currentPageIndex - 1);
      currentPageIndex = currentPageIndex - 1;
      return false; // Prevent the default back navigation
    }
    Navigator.pop(context);
    return true;
    // return tru/e; // Allow the default back navigation
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
      // Set your desired color
    );
    return WillPopScope(
      onWillPop: onBackPressed,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
            key: scaffoldKey, // Assign the global key to the Scaffold
            body: SafeArea(
              child: Column(
                children: [
                  SmoothPageIndicator(
                    controller: pageController,
                    count: 5,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: Colors.blue,
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      dotWidth: 10,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    // height: 600,
                    child: PageView(
                      controller: pageController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      onPageChanged: (pageIndex) {
                        // Only perform validation when going forward (scrolling to the next page)
                        print(pageIndex);
                        print(currentPageIndex);

                        if (pageIndex > currentPageIndex) {
                          bool canScrollForward =
                              true; // Default to allowing forward scroll

                          // Perform validation based on pageIndex
                          if (pageIndex == 1) {
                            // print(inputData.catergory);
                            canScrollForward = inputData.categoryId != null;
                          } else if (pageIndex == 2) {
                            print(inputData.title);

                            canScrollForward = inputData.title != null &&
                                inputData.title != '';
                          } else if (pageIndex == 3) {
                            print(inputData.skills?.length);
                            canScrollForward = inputData.skills?.length != 0 &&
                                inputData.skills != null;
                            // canScrollForward = validationModel.isRegisterMoreValid;
                          } else if (pageIndex == 4) {
                            print(inputData.skills?.length);
                            canScrollForward = inputData.desc != null &&
                                inputData.price != null &&
                                inputData.desc != '' &&
                                inputData.price != '';
                          }

                          if (!canScrollForward) {
                            pageController.jumpToPage(currentPageIndex);
                            showValidationSnackbar();
                            return;
                          }
                        }
                        currentPageIndex =
                            pageIndex; // Update the current page index
                      },
                      children: [
                        RegisterMore(
                            pageController: pageController,
                            bodyprovider: map,
                            isFromAddGig: widget.isFromAddGig,
                            isFromEditGig: widget.isFromEditGig,
                            inputData: inputData),
                        GigTitle(
                            inputData: inputData,
                            pageController: pageController),
                        GigTags(
                            pageController: pageController,
                            inputData: inputData),
                        GigDescription(
                            pageController: pageController,
                            inputData: inputData),
                        AddGig(
                          inputData: inputData,
                          pageController: pageController,
                          isFromEditGig: widget.isFromEditGig,
                          myGig: widget.myGig,
                          isFromAddGig: widget.isFromAddGig,
                          bodyprovider: widget.bodyprovider,
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * 0.02,
                  // ),
                  // SmoothPageIndicator(
                  //   controller: pageController,
                  //   count: 4,
                  //   effect: ExpandingDotsEffect(
                  //     activeDotColor: Colors.blue,
                  //     dotColor: Colors.grey,
                  //     dotHeight: 10,
                  //     dotWidth: 10,
                  //   ),
                  // )
                ],
              ),
            )),
      ),
    );
  }
}
