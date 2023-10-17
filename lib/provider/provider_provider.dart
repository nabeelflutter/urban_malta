import 'package:flutter/material.dart';
import 'package:kappu/models/serializable_model/signedinprovider.dart';

class ProviderProvider extends ChangeNotifier {
  late SignedInProvider provider;
  String token = "";
  late String id;
  late String firstName;
  late String lastName;
  late String email;
  late bool isProvider;
  late String language;
  late String nationality;
  late String phone;
}
