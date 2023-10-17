import 'dart:convert';
import 'dart:io';

// import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kappu/common/bottom_nav_bar.dart';
import 'package:kappu/constants/storage_manager.dart';
import 'package:kappu/net/base_dio.dart';
import 'package:kappu/net/http_client.dart';
import 'package:kappu/screens/home_page/home_screen.dart';
import 'package:kappu/screens/location/add_new_address_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/AppColors.dart';

class ChooseLocationScreen extends StatefulWidget {
  const ChooseLocationScreen(
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
  State<ChooseLocationScreen> createState() => _ChooseLocationScreenState();
}

class _ChooseLocationScreenState extends State<ChooseLocationScreen> {
  bool isLoading = false;

  Future<Position> _determinePosition() async {
    setState(() {
      isLoading = true;
    });
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.

      final value = await Geolocator.getCurrentPosition();

      SharedPreferences preferences = await SharedPreferences.getInstance();

      preferences.setString('currentLocation', 'current');

      if (!(widget.password?.contains('pass') == true)) {
        await onsignup(
            'current', value.latitude.toString(), value.longitude.toString());
      } else {
        print('dusra saman');
      }

      if(mounted) {
        await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  BottomNavBar(isprovider: StorageManager().isProvider)));
      }

      await addLocation(value.latitude, value.longitude, 'current');
      return value;
    } catch (e) {
      return Future.error(e);
    }
  }

  void _locationSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xfff6f9fe),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Padding(
          padding:
              const EdgeInsets.only(right: 12, left: 12, top: 16, bottom: 20),
          child: SizedBox(
            height: 300,
            child: ListView(
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
                const SizedBox(height: 12),
                InkWell(
                  onTap: () async {
                    _determinePosition().then((value) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                        (route) => false,
                      );
                    }).onError((error, stackTrace) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(error?.toString() ?? 'Error')));
                    });
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Ink(
                    height: 65,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: 60,
                            height: 60,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 5),
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Image.asset(
                                "assets/icons/telegram.jpg",
                              ),
                            )),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Expanded(
                                child: Text(
                                  "Use my current location",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.app_black,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Expanded(
                                child: Text(
                                  "Urbanmalta will use your location",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color:
                                        AppColors.app_black.withOpacity(0.65),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddNewAddressScreen(),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Ink(
                    height: 65,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: 60,
                            height: 60,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 5),
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Image.asset(
                                "assets/icons/add.jpg",
                              ),
                            )),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            "Add new address",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.app_black,
                            ),
                            maxLines: 1,
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
      },
    );
  }

  Future<void> addLocation(double lat, double lng, String type) async {
    if (StorageManager().userId == -1) {
      return;
    }

    print(StorageManager().userId);
    const url = 'https://urbanmalta.com/api/location/create';

    var data = FormData.fromMap({
      'user_id': '${StorageManager().userId}',
      'name': 'Malta1',
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

    if (response.statusCode == 200) {
      final shared = await SharedPreferences.getInstance();
      shared.setString('lat', '${lat ?? 0}');
      shared.setString('long', '${lng ?? 0}');
      print(json.encode(response.data));
      print("Success");
    } else {
      print(response.statusMessage);
    }
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
    }).catchError((e) {
      BaseDio.getDioError(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height:
                  Size.fromHeight(AppBar().preferredSize.height).height + 10,
            ),
            GestureDetector(
              onTap: () => _locationSheet(context),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 45,
                    height: 45,
                    child: Image.asset(
                      "assets/images/location.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Choose your location",
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.app_color,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 8),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: Image.asset("assets/icons/arrow_down.png"),
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Image.asset(
                "assets/images/world_map.png",
                fit: BoxFit.cover,
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                _determinePosition().then((value) async {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomNavBar(
                        isprovider: StorageManager().isProvider,
                      ),
                    ),
                    (route) => false,
                  );
                }).onError((error, stackTrace) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(error?.toString() ?? 'Error')));
                });
              },
              borderRadius: BorderRadius.circular(50),
              child: Ink(
                width: double.maxFinite,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.app_color,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      offset: const Offset(1.2, 1.5),
                      color: AppColors.shadow.withOpacity(0.25),
                      blurRadius: 3,
                      spreadRadius: 1.5,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "Share location",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.5,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            // todo uncomment
            InkWell(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddNewAddressScreen(
                      password: widget.password,
                      email: widget.email,
                      name: widget.name,
                      loginType: widget.loginType,
                      socialId: widget.socialId,
                    ),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(50),
              child: Ink(
                width: double.maxFinite,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.app_bg,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      offset: const Offset(1.0, 1.2),
                      color: AppColors.shadow.withOpacity(0.2),
                      blurRadius: 3,
                      spreadRadius: 1.5,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "Enter address manually",
                    style: TextStyle(
                      color: AppColors.app_color,
                      fontSize: 20.5,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}
