import 'package:kappu/models/serializable_model/offer_package.dart';
import 'package:json_annotation/json_annotation.dart';
part 'offer.g.dart';

@JsonSerializable()
class Offers {
  @JsonKey(name: 'id')
  int offerid;
  @JsonKey(name: 'title')
  String offertitle;
  @JsonKey(name: 'description')
  String offerDescription;
  @JsonKey(name: 'packages')
  List<Offerpackage> packages;
  @JsonKey(name: 'is_paused')
  bool ispaused;
  int userid;
  @JsonKey(name: 'first_name')
  String userfirstname;
  @JsonKey(name: 'last_name')
  String userlastname;
  @JsonKey(name: 'rating_count')
  double averagerating;

  @JsonKey(name: 'review_count')
  int reviewcount;
  Offers(
      {required this.packages,
      required this.offerid,
      required this.offertitle,
      required this.offerDescription,
      required this.ispaused,
      required this.userid,
      required this.userfirstname,
      required this.userlastname,
      required this.averagerating,
      required this.reviewcount});

  factory Offers.fromJson(Map<String, dynamic> json) => _$OffersFromJson(json);

  /// Connect the generated [_$SignInToJson] function to the `toJson` method.

  Map<String, dynamic> toJson() => _$OffersToJson(this);
}
