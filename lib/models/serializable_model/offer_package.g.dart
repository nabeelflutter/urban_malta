// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_package.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Offerpackage _$OfferpackageFromJson(Map<String, dynamic> json) => Offerpackage(
      packageid: json['id'] as int?,
      packagetitle: json['title'] as String,
      packagePrice: double.parse(json['price']),
      packageServicetime: json['time'] as String,
      packagelocation: json['location'] as String,
    );

Map<String, dynamic> _$OfferpackageToJson(Offerpackage instance) =>
    <String, dynamic>{
      'id': instance.packageid,
      'title': instance.packagetitle,
      'price': instance.packagePrice,
      'time': instance.packageServicetime,
      'location': instance.packagelocation,
    };
