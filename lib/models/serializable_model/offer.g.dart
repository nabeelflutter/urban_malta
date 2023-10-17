// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Offers _$OffersFromJson(Map<String, dynamic> json) => Offers(
    packages: (json['packages'] as List<dynamic>)
        .map((e) => Offerpackage.fromJson(e as Map<String, dynamic>))
        .toList(),
    offerid: json['id'] as int,
    offertitle: json['title'] as String,
    offerDescription: json['description'] as String,
    ispaused: json['is_paused'] as bool,
    userid: json['user']['id'] as int,
    userfirstname: json['user']['first_name'] as String,
    userlastname: json['user']['last_name'] as String,
    averagerating: json['rating_count'] as double,
    reviewcount: json['review_count'] as int);

Map<String, dynamic> _$OffersToJson(Offers instance) => <String, dynamic>{
      'id': instance.offerid,
      'title': instance.offertitle,
      'description': instance.offerDescription,
      'packages': instance.packages,
      'is_paused': instance.ispaused,
      'userid': instance.userid,
      'first_name': instance.userfirstname,
      'last_name': instance.userlastname,
    };
