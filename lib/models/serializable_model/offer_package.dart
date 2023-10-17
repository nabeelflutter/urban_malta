import 'package:json_annotation/json_annotation.dart';
part 'offer_package.g.dart';

@JsonSerializable()
class Offerpackage {
  @JsonKey(name: 'id')
  int? packageid;
  @JsonKey(name: 'title')
  String packagetitle;
  @JsonKey(name: 'price')
  double packagePrice;
  @JsonKey(name: 'time')
  String packageServicetime;
  @JsonKey(name: 'location')
  String packagelocation;
  int packageservicequantity;

  Offerpackage(
      {this.packageid,
      required this.packagetitle,
      required this.packagePrice,
      required this.packageServicetime,
      required this.packagelocation,
      this.packageservicequantity = 0});

  factory Offerpackage.fromJson(Map<String, dynamic> json) =>
      _$OfferpackageFromJson(json);

  /// Connect the generated [_$SignInToJson] function to the `toJson` method.

  Map<String, dynamic> toJson() => _$OfferpackageToJson(this);
}

List<Offerpackage> packagebought = [
  Offerpackage(
      packageid: 0,
      packagetitle: 'Bathroom Cleaning',
      packagePrice: 33,
      packageServicetime: '2 hr 30 min',
      packagelocation: ''),
  Offerpackage(
      packageid: 0,
      packagetitle: 'Bathroom Floor Cleaning',
      packagePrice: 23,
      packageServicetime: '30 min',
      packagelocation: ''),
  Offerpackage(
      packageid: 0,
      packagetitle: 'Wash Basin Cleaning',
      packagePrice: 12,
      packageServicetime: '2 hr 30 min',
      packagelocation: ''),
];

List<Offerpackage> temppackage = [
  Offerpackage(
      packageid: 0,
      packagetitle: '1 BKH',
      packagePrice: 233,
      packageServicetime: '2 hr 30 min',
      packagelocation: ''),
  Offerpackage(
      packageid: 0,
      packagetitle: '2 BKH',
      packagePrice: 455,
      packageServicetime: '4 hr 30 min',
      packagelocation: ''),
];
