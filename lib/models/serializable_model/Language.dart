import 'package:json_annotation/json_annotation.dart';
part 'Language.g.dart';

@JsonSerializable()
class Language {
//  @JsonKey(name: 'id')
  int id;
// @JsonKey(name: 'name')
  String name;

  Language({required this.id, required this.name});

  factory Language.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  /// Connect the generated [_$SignInToJson] function to the `toJson` method.

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}