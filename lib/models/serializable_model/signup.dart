import 'package:json_annotation/json_annotation.dart';

part 'signup.g.dart';

@JsonSerializable()
class UserSignUpModel {
  int id;
  String name;
  String email;
  @JsonKey(name: 'phone_number')
  String phonenumber;
  String lat;
  String lng;

  UserSignUpModel({
    required this.id,
    required this.lat,
    required this.lng,
    required this.email,

    required this.name,
    required this.phonenumber,
  });

  /// Connect the generated [_$SignUpFromJson] function to the `fromJson`
  /// factory.
  factory UserSignUpModel.fromJson(Map<String, dynamic> json) => _$UserSignUpModelFromJson(json);

  /// Connect the generated [_$SignUpToJson] function to the `toJson` method.

  Map<String, dynamic> toJson(UserSignUpModel usermodel) => _$UserSignUpModelToJson(this);
}
