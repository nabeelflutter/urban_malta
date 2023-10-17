import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/common/validation_dialogbox.dart';
import 'package:kappu/components/MyAppBar.dart';
import 'package:kappu/constants/storage_manager.dart';
import 'package:kappu/models/serializable_model/GigListResponse.dart';
import 'package:kappu/net/http_client.dart';
import 'package:kappu/screens/gig/Create_first_gig.dart';
import 'package:kappu/screens/gig/GigItemWidget.dart';
import 'package:kappu/screens/register/register_more.dart';

import '../../components/AppColors.dart';
import '../../net/base_dio.dart';

class GigListPage extends StatefulWidget {
  const GigListPage({Key? key}) : super(key: key);

  @override
  State<GigListPage> createState() => GigListPageState();
}

class GigListPageState extends State<GigListPage> {
  reloadpage() {
    setState(() {});
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
        ),
        title: const Text(
          'GIGs List',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      backgroundColor: const Color(0xfff2f7fd),
      body: FutureBuilder(
          future: HttpClient().getGigList(),
          builder: (context, AsyncSnapshot<List<GigListResponse>> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data == null || snapshot.data!.isEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: Column(
                    children: [
                      const Text("No Gig Found",
                          style: TextStyle(
                              color: Colors.black,
                              // fontFamily: "Montserrat-Regular"
                              )),
                      TextButton(
                          onPressed: () {
                            setState(() {});
                          },
                          child: const Text('Reload')),
                    ],
                  ),
                ),
              );
            }
            // return ListView(
            //   padding: const EdgeInsets.only(bottom: 50),
            //   scrollDirection: Axis.vertical,
            //   shrinkWrap: true,
            //   children: snapshot.data!
            //       .map((item) => Padding(
            //     padding: EdgeInsets.all(
            //         ScreenUtil().setHeight(10)),
            //     child: GigItemWidget(
            //       item: item,
            //       menuItemClicked: (String value) {
            //         callAPI(context, item, value);
            //       },
            //     ),
            //   ))
            //       .toList(),
            // );

            return Container(
              padding: const EdgeInsets.only(left: 10, right: 15, top: 10),
              child: ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  // Check if snapshot.data is null or empty
                  if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text("No Gig Found",
                          style: TextStyle(
                              color: Colors.black,
                              // fontFamily: "Montserrat-Regular"
                              )),
                    );
                  }

                  // Get the GigListResponse item at the current index
                  GigListResponse item = snapshot.data![index];

                  // Build your UI here for each GigItemWidget
                  return GigItemWidget(
                    item: item,
                    menuItemClicked: (String value) {
                      callAPI(context, item, value);
                    },
                  );
                },
              ),
            );
          }),
    );
  }

  //
  // Column(
  // children: [
  // Container(
  // padding: EdgeInsets.only(right: 10),
  // height: 150,
  // decoration: BoxDecoration(
  // color: Colors.white,
  // borderRadius: BorderRadius.circular(10),
  // ),
  // child: LayoutBuilder(
  // builder:
  // (BuildContext context, BoxConstraints constraints) {
  // double imageWidth = constraints.maxWidth * 0.35;
  // double imageHeight = constraints.maxHeight * 0.9;
  // double infoWidth = constraints.maxWidth * 0.55;
  //
  // return Row(
  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  // children: [
  // Container(
  // width: imageWidth,
  // child: Image.asset(
  // 'assets/images/j14.png',
  // height: imageHeight,
  // fit: BoxFit.fitHeight,
  // ),
  // ),
  // Container(
  // width: infoWidth,
  // child: Column(
  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  // children: [
  // const Text(
  // 'I will provide you house cleaning service',
  // style: TextStyle(
  // fontSize: 15,
  // color: Color(0xff7B7D83),
  // ),
  // ),
  // Row(
  // children: [
  // Text(
  // '4.5',
  // style: TextStyle(
  // color: Color(0xffF79E1F),
  // fontSize: 15,
  // ),
  // ),
  // SizedBox(width: 10),
  // Text(
  // '(125 Rating)',
  // style: TextStyle(
  // color: Color(0xff7B7D83),
  // fontSize: 15,
  // ),
  // ),
  // ],
  // ),
  // Row(
  // mainAxisAlignment:
  // MainAxisAlignment.spaceBetween,
  // children: [
  // Text(
  // 'Hourly Price',
  // style: TextStyle(
  // fontSize: 15,
  // color: Color(0xff161616),
  // ),
  // ),
  // Text(
  // '€10',
  // style: TextStyle(
  // fontSize: 18,
  // color: Color(0xff161616),
  // fontWeight: FontWeight.w700,
  // ),
  // ),
  // ],
  // ),
  // ],
  // ),
  // ),
  // ],
  // );
  // },
  // ),
  // ),
  // SizedBox(height: 15),
  // ],
  // )

  Future<void> callAPI(
      BuildContext context, GigListResponse item, String value) async {
    // setState(() {
    //   isLoading = true;
    // });
    if (value == 'edit') {
      Map<String, dynamic> map = {};
      final result = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FirstGigPage(
                  bodyprovider: map, isFromEditGig: true, myGig: item)));

      if (result == "1") {
        setState(() {});
      }
    } else if (value == 'delete') {
      deleteGig(item);
    }
  }

  deleteGig(item) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return WarningDialogBox(
            title: "Delete?",
            descriptions: "Are You sure You want to Delete?",
            buttonTitle: "ok",
            onPressed: () async {
              Navigator.pop(context);
              await HttpClient()
                  .deleteGig(item.id.toString(),
                      "Bearer " + StorageManager().accessToken)
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
            },
            icon: Icons.cancel,
          );
        });
  }
}
