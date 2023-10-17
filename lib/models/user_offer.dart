import 'package:kappu/models/serializable_model/offer_package.dart';

class UserOffer {
  String userofferid;
  List<Offerpackage> packages;
  double totalprice;
  String date;
  String time;

  UserOffer(
      {required this.userofferid,
      required this.packages,
      required this.totalprice,
      required this.date,
      required this.time});
}
