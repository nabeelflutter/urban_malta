import 'dart:convert';
import 'dart:io';

import 'package:address_search_field/address_search_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kappu/common/bottom_nav_bar.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/constants/storage_manager.dart';
import 'package:kappu/net/base_dio.dart';
import 'package:kappu/net/http_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen(
      {Key? key,
      this.loginType,
      this.socialId,
      this.name,
      this.email,
      this.password})
      : super(key: key);
  final String? loginType;
  final String? socialId;
  final String? name;
  final String? email;
  final String? password;

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  final mapApiKey = 'AIzaSyBQ9lQB1rZr_WODQi3IeuLFZYbwnGTAC2c';
  final addressController = TextEditingController();
  List<Address> address = [];
  bool isSelected = false;

  late final geo = GeoMethods(
    googleApiKey: mapApiKey,
    language: 'en',
    countryCode: 'MT',
    countryCodes: ['MT'],
    country: "Malta",
  );

  Future<void> loadData(String search) async {
    final address = await geo.autocompletePlace(query: search);

    setState(() {
      this.address = address;
      isSelected = false;
    });
  }

  Future<LatLng?> getLocation(String ref) async {
    final locations = await locationFromAddress(ref);

    if (locations.isEmpty) {
      return null;
    }

    return LatLng(locations.first.latitude, locations.first.longitude);
  }

  Future<void> onsignup(String address, String lat, String long) async {
    Map<String, dynamic> body = widget.socialId == null || widget.socialId == ''
        ? {
            'first_name': widget.name,
            'username': "",
            'last_name': "",
            'email': widget.email,
            'phone_number': "",
            'password': widget.password,
            'fcm_token': StorageManager().fcmToken,
            'os': Platform.isAndroid ? 'android' : 'ios',
            'language': "English",
            'nationality': "Malta",
            'login_src': '',
            // 'location': selectedPlace?.formattedAddress,
            'social_login_id': '',
            'location': address,
            'lat': lat,
            'lng': long,
          }
        : {
            'first_name': widget.name,
            'username': "",
            'last_name': "",
            'email': widget.email,
            'phone_number': "",
            'lat': lat,
            'location': address,
            'lng': long,
            'password': '',
            'login_src': widget.loginType,
            'social_login_id': widget.socialId,
            'fcm_token': StorageManager().fcmToken,
            'os': Platform.isAndroid ? 'android' : 'ios',
            'language': "English",
            'nationality': "Malta",
          };
    print('lattitude $lat');

    print('longitude $long');
    await HttpClient().userSignup(body, File("path")).then((value) async {
      if (value?.data['status']) {
        var provider = StorageManager();
        provider.accessToken = value?.data['token'];
        provider.name = widget.name!;

        // provider.phone = _phnocontroller.text;
        provider.email = widget.email!;
        provider.isProvider = false;
        provider.isSocialUser = widget.socialId!.isNotEmpty ? true : false;
        provider.userId = value?.data['user']['id'];
        provider.nationality = value?.data['user']['nationality'];
        provider.language = value?.data['user']['languages'];
        provider.stripeId = "" + value?.data['user']['customer_stripe_id'];
      }
      print('printing signature data' + value!.data.toString());
    }).catchError((e) {
      BaseDio.getDioError(e);
    });
  }

  Future<void> addLocation(
      double? lat, double? lng, String type, String name) async {
    if (StorageManager().userId == -1) {
      return;
    }
    const url =
        'https://urbanmalta.com/api/location/create'; // Replace with the actual API endpoint

    var data = FormData.fromMap({
      'user_id': '${StorageManager().userId}',
      'name': name,
      'lat': '$lat',
      'lng': '$lng',
      'type': type,
      'is_default': '0'
    });

    var headers = {
      'Authorization': 'Bearer ${StorageManager().accessToken}',
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6ImVkeEllU2F2aUo2eHpRd1F1cTFSdmc9PSIsInZhbHVlIjoieFJlMkk1MVRKalpjdXVEaWJrYnFJVXlhRnYrdFAvZy9lUS9zUTFJZ21aOTMvQWpseXJYeWhVWXhoeW54NnZ5U3Y1NXA5RHJHMmx0RVhwSlBNTUoxM3lOYTNkMDZIa3hObDM0aFMrQy9aSGNsQnpBYXpXOG1RbGVYNE5ycDc3Y2giLCJtYWMiOiI5OWYxNzM2ZTcxNGNmOGQ1NWNlOWY3ZDdiYTk1ZjUyN2ZiY2VmYTc5NzcxY2Y0MjhiM2I5ZDU3NzlkOWI2MGYxIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6Ik9ubVRlRXIxb2EwU0lEY0JRVldJdXc9PSIsInZhbHVlIjoidkF5Tmw2dzZZcUxNY1lpTFp5dzdUNWlxKzVoT2hxZUErb3E1QnU5ZDQ4bkJTaUYrQlh1MW5wR3pkWTdQNzg4SEZFMHVDVEF4WVU4ZHFDOXh3cEx5WEp5OUJvMWE5c3BxM1c4N1NqMnAzaXR2ejZPNTJyTDVOVVpiTjlWSzNqUlQiLCJtYWMiOiJjZDM3NGM1ZDI5ZDBjMjU0NTVlZjgzM2QxYWNjZjRmZGRmMGE5YTMwOTdjNzc0OTI1ZDU2MTEzOTNiM2Y4ODI2IiwidGFnIjoiIn0%3D'
    };

    var dio = Dio();
    var response = await dio.request(
      'https://urbanmalta.com/api/location/create',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    print(";;");
    print(response.data);

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      final shared = await SharedPreferences.getInstance();
      shared.setString('lat', '${lat ?? 0}');
      shared.setString('long', '${lng ?? 0}');
      await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) =>
              BottomNavBar(isprovider: StorageManager().isProvider),
        ),
        (route) => false,
      );
    } else {
      print(response.statusMessage);
    }
  }

  Future<void> getAddress() async {
    final loc = await getLocation(addressController.text);

    if (loc?.latitude != null && loc?.longitude != null) {
      if (!(widget.password?.contains('pass') == true)) {
        await onsignup(
            'current', loc!.latitude.toString(), loc.longitude.toString());
      } else {
        print('dusra saman');
      }


      await addLocation(loc!.latitude, loc.longitude, 'manual',
          addressController.text ?? 'Malta');

        await Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    BottomNavBar(isprovider: StorageManager().isProvider)),(route) => false,);

    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("We are not available in this location"),
            actions: [
              TextButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Ok"))
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.app_bg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.app_bg,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30),
              const Text(
                "Add new address",
                style: TextStyle(
                  fontSize: 27,
                ),
              ),
              const SizedBox(height: 30),
              Container(
                height: 85,
                width: double.maxFinite,
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      offset: const Offset(3, 3),
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 3,
                    )
                  ],
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Country",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      "Malta",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      offset: const Offset(3, 3),
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 3,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    onChanged: loadData,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(0.85),
                    ),
                    controller: addressController,
                    decoration: InputDecoration(
                      hintText: "Street name and number",
                      hintStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w200,
                        color: Colors.black.withOpacity(0.54),
                      ),
                      filled: true,
                      focusColor: Colors.transparent,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 30,
                      ),
                    ),
                  ),
                ),
              ),
              if (isSelected == true)
                GestureDetector(
                  onTap: () async {
                    if (isSelected == true) {
                      await getAddress();
                    } else {
                      print('please select address');
                    }
                  },
                  child: Center(
                    child: Container(
                      height: 40,
                      width: 100,
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(vertical:  20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black),
                      child: const Text(
                        'Next',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              if (address.isNotEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text("Choose Address",
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                ),
              address.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: address.length,
                        itemBuilder: (context, index) {
                          return address[index].reference == null
                              ? const SizedBox()
                              : GestureDetector(
                                  onTap: () async {
                                    addressController.text =
                                        address[index].reference!;
                                    isSelected = true;
                                    setState(() {});
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          offset: const Offset(3, 3),
                                          color: Colors.black.withOpacity(0.12),
                                          blurRadius: 3,
                                        )
                                      ],
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 50,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey.withOpacity(0.5),
                                          ),
                                          child: const Icon(
                                            Icons.location_on_rounded,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                              address[index].reference ?? '',
                                              textAlign: TextAlign.start),
                                        ),
                                        const Icon(
                                          Icons.north_west_rounded,
                                          size: 25,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                        },
                      ),
                    )
                  : Center(
                      child: SizedBox(
                        width: size.width * 0.75,
                        height: size.width * 0.75,
                        child: Image.asset("assets/images/location_on_map.png"),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
