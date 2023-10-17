import 'package:json_annotation/json_annotation.dart';

part 'signedinprovider.g.dart';

@JsonSerializable()
class SignedInProvider {
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'email')
  String email;
  @JsonKey(name: 'first_name')
  String firstname;
  @JsonKey(name: 'last_name')
  String lastname;
  @JsonKey(name: 'phone_number')
  String phno;

  @JsonKey(name: 'is_provider')
  bool isprovider;

  @JsonKey(name: 'category')
  int? catagoryid;

  SignedInProvider({
    required this.id,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.phno,
    required this.isprovider,
    this.catagoryid,
  });

  /// Connect the generated [_$SignInFromJson] function to the `fromJson`
  /// factory.
  factory SignedInProvider.fromJson(Map<String, dynamic> json) =>
      _$SignedInProviderFromJson(json);

  /// Connect the generated [_$SignInToJson] function to the `toJson` method.

  Map<String, dynamic> toJson() => _$SignedInProviderToJson(this);
}
