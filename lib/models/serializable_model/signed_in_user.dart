import 'package:json_annotation/json_annotation.dart';

part 'signed_in_user.g.dart';

@JsonSerializable()
class SignedInuser {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'email')
  String email;

  @JsonKey(name: 'first_name')
  String fname;
  @JsonKey(name: 'last_name')
  String lname;

  @JsonKey(name: 'phone_number')
  String phno;
  @JsonKey(name: 'address')
  String address;

  String state;
  String city;
  int addressid;
  SignedInuser({
    required this.id,
    required this.email,
    required this.fname,
    required this.lname,
    required this.phno,
    required this.address,
    required this.addressid,
    required this.state,
    required this.city,
  });

  /// Connect the generated [_$SignInFromJson] function to the `fromJson`
  /// factory.
  factory SignedInuser.fromJson(Map<String, dynamic> json) =>
      _$SignedInuserFromJson(json);

  /// Connect the generated [_$SignInToJson] function to the `toJson` method.

  Map<String, dynamic> toJson() => _$SignedInuserToJson(this);
}
