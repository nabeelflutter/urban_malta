part of 'Language.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Language _$CategoryFromJson(Map<String, dynamic> json) => Language(
  id: json['id'] as int,
  name: json['name'] as String,
);

Map<String, dynamic> _$CategoryToJson(Language instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};