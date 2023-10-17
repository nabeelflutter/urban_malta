import 'package:json_annotation/json_annotation.dart';

part 'forget_password_response.g.dart';

@JsonSerializable()
class ForgetPasswordResponse {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'email')
  String email;

  @JsonKey(name: 'phone_number')
  String phonenumber;

  ForgetPasswordResponse({
    required this.id,
    required this.email,
    required this.phonenumber,
  });

  /// Connect the generated [_$SignUpFromJson] function to the `fromJson`
  /// factory.
  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordResponseFromJson(json);

  /// Connect the generated [_$SignUpToJson] function to the `toJson` method.

  Map<String, dynamic> toJson(ForgetPasswordResponse usermodel) =>
      _$ForgetPasswordResponseToJson(this);
}
