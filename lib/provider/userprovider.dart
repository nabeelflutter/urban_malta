import 'package:flutter/material.dart';

import '../models/serializable_model/signed_in_user.dart';

class UserProvider extends ChangeNotifier {
  late SignedInuser user;
  String token = '';
  String userprofilepicurl = '';
  String cutomorid = '';
}
