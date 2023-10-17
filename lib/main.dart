import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_keyhash/flutter_facebook_keyhash.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:kappu/common/bottom_nav_bar.dart';
import 'package:kappu/constants/storage_manager.dart';
import 'package:kappu/provider/provider_provider.dart';
import 'package:kappu/provider/userprovider.dart';
import 'package:kappu/screens/errors/no_internet.dart';
import 'package:kappu/screens/location/choose_location_screen.dart';
import 'package:kappu/screens/login/splash_view.dart';
import 'package:provider/provider.dart';

import 'main_context.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // print('Handling a background message ${message.messageId}');
}

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void printKeyHash() async {
  String? key = await FlutterFacebookKeyhash.getFaceBookKeyHash ?? 'Unknown platform version';
  print("abdullah bhai " + key ?? "");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager().init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white, statusBarColor: Colors.white, systemNavigationBarIconBrightness: Brightness.dark));
  await Firebase.initializeApp();

  if (Platform.isAndroid) {
    printKeyHash();
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  // await messaging.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);

  // await messaging.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );

  Stripe.publishableKey = 'pk_live_51NATS9SERYQxgiaZKDgjeXEXVXKVyVlUN7gT5NzxVIzMcgDExy1WzRsZFGZcc55PU2C2Sd6bMMbfrdL5OzaVz3Fr00CIViJtjK';

  ///farooq // 'pk_test_51NXrWpIT6hf4mQbFXs7a4nPBogv8HqwtiARzLSg1cmA9h19kYXB14kbltiPOjo1FBRBn14HKlLctM99CAPHuL8Wq00AC8dImTi';

  runApp(Phoenix(child: MyApp(messaging: messaging)));
}

class MyApp extends StatefulWidget {
  final FirebaseMessaging messaging;

  const MyApp({Key? key, required this.messaging}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _hasInternet = true;

  Future<String> _base64encodedImage(String url) async {
    final http.Response response = await http.get(Uri.parse(url));
    final String base64Data = base64Encode(response.bodyBytes);
    return base64Data;
  }

  Future<void> _checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _hasInternet = connectivityResult != ConnectivityResult.none;
    });
  }

  String largeIconPath = '';

  // Future<void> checkPermission() async {
  //   // ignore: unused_local_variable
  //   Map<Permission, PermissionStatus> statuses = await [
  //     Permission.location,
  //   ].request();
  //   var status = await Permission.location.request();
  //   if (status.isGranted) {
  //   } else if (status.isDenied) {
  //     checkPermission();
  //   } else if (status.isPermanentlyDenied) {
  //     showLocationDialogBox();
  //   }
  // }

  // Future<void> showLocationDialogBox() async {
  //   return showDialog(
  //     context: context,
  //     builder: (context) {
  //       return Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: [
  //           InkWell(
  //             onTap: () {
  //               Navigator.pop(context);
  //             },
  //             child: SizedBox(
  //               width: 30.w,
  //               height: 8.h,
  //               child: const Text("Cancel"),
  //             ),
  //           ),
  //           InkWell(
  //             onTap: () {
  //               Navigator.pop(context);
  //               OpenSettings.openLocationSourceSetting();
  //             },
  //             child: SizedBox(
  //               width: 30.w,
  //               height: 8.h,
  //               child: const Text("Setting"),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
    // checkPermission();

    Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        _hasInternet = result != ConnectivityResult.none;
      });
    });

    var initialzationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingios = const IOSInitializationSettings();
    var initializationSettings = InitializationSettings(android: initialzationSettingsAndroid, iOS: initializationSettingios);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        // print("showing notification");
        final String largeIcon = await _base64encodedImage(message.notification!.android!.imageUrl!);
        final String bigPicture = await _base64encodedImage(message.notification!.android!.imageUrl!);
        final BigPictureStyleInformation bigPictureStyleInformation =
            BigPictureStyleInformation(ByteArrayAndroidBitmap.fromBase64String(bigPicture), //Base64AndroidBitmap(bigPicture),
                largeIcon: ByteArrayAndroidBitmap.fromBase64String(largeIcon),
                contentTitle: '<b>${message.notification!.title}</b>',
                htmlFormatContentTitle: true,
                summaryText: message.notification!.body,
                htmlFormatSummaryText: true);

        final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails('big text channel id', 'big text channel name',
            channelDescription: 'big text channel description', styleInformation: bigPictureStyleInformation);
        final NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
        await flutterLocalNotificationsPlugin.show(0, message.notification!.title, message.notification!.body, platformChannelSpecifics);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // print(">>>>>>>>>>>>>");
      // print(message.data);
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });

    getToken();
  }

  String token = '';

  getToken() async {
    token = (await widget.messaging.getToken())!;
    StorageManager().fcmToken = token;
    // print("!!!!!!!!!!!!!!!");
    // print(token);
  }

  // GoogleSignInAccount? _currentuser;

  // @override
  // void initState() {
  //   _googleSignIn.onCurrentUserChanged.listen(
  //     (account) {
  //       setState(() {
  //         _currentuser = account;
  //       });
  //     },
  //   );
  //   _googleSignIn.signInSilently();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // GoogleSignInAccount? user = _currentuser;

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ProviderProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => UserProvider(),
          ),
        ],
        child: MaterialApp(
          navigatorKey: NavigationService.navigatorKey,
          title: 'UrbanMalta',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(scaffoldBackgroundColor: Colors.white, fontFamily: 'Raleway'),
          home: _hasInternet
              // ? const InitialScreen()
              ? WillPopScope(onWillPop: () async => !await NavigationService.navigatorKey.currentState!.maybePop(), child: const InitialScreen())
              : NoInternetScreen(), // Show the NoInternetScreen when there's no internet,
        ),
      ),
    );
  }
}

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: StorageManager().accessToken.isNotEmpty
          ? BottomNavBar(
              //todo
              isprovider:StorageManager().isProvider,
            )
          : const SplashView(),

      // TODO : location page will be relocate
      // body: ChooseLocationScreen(),
    );
  }
}
//flutter clean
//flutter packages get
//flutter downgrade
//flutter run
