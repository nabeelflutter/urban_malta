import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/components/MyAppBar.dart';
import 'package:kappu/components/ProviderItem.dart';
import 'package:kappu/models/serializable_model/RecommendedServiceProvidersResponse.dart';
import 'package:kappu/net/http_client.dart';

import '../home_page/widgets/search_text_field.dart';

class SearchCatagoriesScreen extends StatefulWidget {
  String? searchtext;
  SearchCatagoriesScreen({this.searchtext});

  @override
  _SearchCatagoriesScreenState createState() => _SearchCatagoriesScreenState();
}

class _SearchCatagoriesScreenState extends State<SearchCatagoriesScreen> {
  List<RecommendedServiceProvidersResponse> tempData = [];
  bool isLoading = false;
  String searchText = "";

  @override
  void initState() {
    searchText = widget.searchtext??"";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Search Service",
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              // fontFamily: "Montserrat-Bold"
              ),
        ),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back_ios_new,color: AppColors.iconColor,))
        // const BackButton(
        //   color: AppColors.iconColor,
        // ),
      ),
        body: isLoading
            ? const Center(child:CircularProgressIndicator())
            : Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(6)),
                    child: SearchTextField(
                      hintext: "Search Services",
                      value: this.searchText,
                      onSearchingComplete: (value) {
                        print(value);
                        if(value.length>2){
                          setState(() {
                            searchText = value;
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  Expanded(
                      child: FutureBuilder(
                          future: HttpClient().searchServiceProviders(this.searchText),
                          builder: (context,
                              AsyncSnapshot<List<RecommendedServiceProvidersResponse>> response) {
                            if (response.connectionState != ConnectionState.done) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return ListView.separated(
                              shrinkWrap: true,
                              itemCount: response.data!.length,
                              itemBuilder: (context, position) {
                                return ItemServicesCard(data : response.data![position]);
                              }
                              ,
                              separatorBuilder: (context, index) =>
                                  SizedBox(
                                    height: 10,
                                  )
                              ,
                            );

                          })
                  )
                ],
              ));
  }

}
