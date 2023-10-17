// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packagebought.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageBought _$PackageBoughtFromJson(Map<String, dynamic> json) {
  return PackageBought(
    package: Offerpackage.fromJson(json['package'] as Map<String, dynamic>),
    quantity: json['quantity'] as String,
    price: json['price'] as String,
  );
}

Map<String, dynamic> _$PackageBoughtToJson(PackageBought instance) =>
    <String, dynamic>{
      'package': instance.package,
      'quantity': instance.quantity,
      'price': instance.price,
    };
