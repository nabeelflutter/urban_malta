import 'package:json_annotation/json_annotation.dart';

part 'provider_profile.g.dart';

@JsonSerializable()
class ProviderProfile {
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
  @JsonKey(name: 'average_rating')
  double averagerating;
  @JsonKey(name: 'completed_orders')
  int completedorders;
  String? profilepicture;
  @JsonKey(name: 'total_reviews')
  int totalreviews;
  String? bio;
  String skill;

  ProviderProfile(
      {required this.id,
      required this.email,
      required this.firstname,
      required this.lastname,
      required this.phno,
      required this.completedorders,
      required this.averagerating,
      this.profilepicture,
      this.bio,
      required this.skill,
      required this.totalreviews});

  /// Connect the generated [_$SignInFromJson] function to the `fromJson`
  /// factory.
  factory ProviderProfile.fromJson(Map<String, dynamic> json) =>
      _$ProviderProfileFromJson(json);

  /// Connect the generated [_$SignInToJson] function to the `toJson` method.

  Map<String, dynamic> toJson() => _$ProviderProfileToJson(this);
}
