import 'package:shared_preferences/shared_preferences.dart';

/// To store local storage .
///
/// For e.g userId, access token.
class StorageManager {
  factory StorageManager() {
    return _instance;
  }

  StorageManager._internal();

  static final StorageManager _instance = StorageManager._internal();

  SharedPreferences? _userPreferences;

  bool get isInitialized => _userPreferences != null;

  Future<void> init() async {
    _userPreferences = await SharedPreferences.getInstance();
  }

  Future<void> clear() async {
    // organizationId = null;

    await _userPreferences!.clear();
  }

  int get userId => _userPreferences?.getInt('userId') ?? -1;
  String get stripeId => _userPreferences?.getString('stripeId') ?? "";
  String get userImage => _userPreferences?.getString('userImage') ?? "";
  double get rating => _userPreferences?.getDouble('rating') ?? 0.0;

  set userId(int id) {
    _userPreferences!.setInt('userId', id);
  }

  set stripeId(String id) {
    _userPreferences!.setString('stripeId', id);
  }

  set setNotificationIcon(bool noti) {
    _userPreferences!.setBool('bol', noti);
  }

  set userImage(String id) {
    _userPreferences!.setString('userImage', id);
  }

  set rating(double rate) {
    _userPreferences!.setDouble('rating', rate);
  }

  String get name => _userPreferences!.getString('name') ?? '';
  String get lastname => _userPreferences!.getString('lastname') ?? '';
  String get phone => _userPreferences!.getString('phone') ?? '';

  set name(String s) {
    _userPreferences!.setString('name', s);
  }

  set lastname(String s) {
    _userPreferences!.setString('lastname', s);
  }

  set phone(String s) {
    _userPreferences!.setString('phone', s);
  }

  String get email => _userPreferences!.getString('email') ?? '';

  set email(String s) {
    _userPreferences!.setString('email', s);
  }

  String get nationality => _userPreferences!.getString('nationality') ?? '';

  set nationality(String s) {
    _userPreferences!.setString('nationality', s);
  }

  String get language => _userPreferences!.getString('language') ?? '';

  set language(String s) {
    _userPreferences!.setString('language', s);
  }

  bool get isProvider => _userPreferences!.getBool('isProvider') ?? false;
  bool get isSocialUser => _userPreferences!.getBool('isSocialUser') ?? false;

  set isProvider(bool s) {
    _userPreferences!.setBool('isProvider', s);
  }

  set isSocialUser(bool s) {
    _userPreferences!.setBool('isSocialUser', s);
  }

  String get accessToken => _userPreferences!.getString('accessToken') ?? '';
  bool get getNotificationIcon => _userPreferences!.getBool('bol') ?? false;

  set accessToken(String data) {
    _userPreferences!.setString('accessToken', data);
  }

  String get fcmToken => _userPreferences!.getString('fcmToken') ?? '';

  set fcmToken(String data) {
    _userPreferences!.setString('fcmToken', data);
  }
}