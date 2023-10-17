import 'package:json_annotation/json_annotation.dart';
import 'package:kappu/models/serializable_model/packagebought.dart';
part 'booking.g.dart';

@JsonSerializable()
class Booking {
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'first_name')
  String userfname;
  @JsonKey(name: 'last_name')
  String userlname;
  @JsonKey(name: 'email')
  String useremail;
  int userid;
  int providerid;
  String providerfname;
  String providerlname;
  String provideremail;
  @JsonKey(name: 'location')
  String location;
  @JsonKey(name: 'address')
  String address;
  @JsonKey(name: 'total_price')
  double totalprice;
  @JsonKey(name: 'time')
  String time;
  int serviceid;
  String servicetitle;
  String comments;
  double rating;

  List<PackageBought> boughtpackages;
  Booking(
      {required this.id,
      required this.userfname,
      required this.userlname,
      required this.useremail,
      required this.userid,
      required this.providerid,
      required this.providerfname,
      required this.providerlname,
      required this.provideremail,
      required this.location,
      required this.address,
      required this.time,
      required this.totalprice,
      required this.serviceid,
      required this.servicetitle,
      required this.boughtpackages,
      required this.comments,
      required this.rating});

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);

  /// Connect the generated [_$SignInToJson] function to the `toJson` method.

  Map<String, dynamic> toJson() => _$BookingToJson(this);
}
