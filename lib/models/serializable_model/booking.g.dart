// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Booking _$BookingFromJson(Map<String, dynamic> json) {
  String comments = '';
  double rating = 0;
  if (json['status']['comments'] != null) {
    comments = json['status']['comments'];
  }
  if (json['reviews'] != null) {
    rating = json['reviews']['rating'];
  }
  return Booking(
    id: json['id'] as int,
    userfname: json['user']['first_name'] as String,
    userlname: json['user']['last_name'] as String,
    useremail: json['user']['email'] as String,
    userid: json['user']['id'] as int,
    providerid: json['provider']['id'] as int,
    providerfname: json['provider']['first_name'] as String,
    providerlname: json['provider']['last_name'] as String,
    provideremail: json['provider']['email'] as String,
    location: json['location'] as String,
    address: json['address'] as String,
    time: json['time'] as String,
    serviceid: json['service']['id'],
    servicetitle: json['service']['title'],
    comments: comments,
    rating: rating,
    totalprice: (json['total_price'] as num).toDouble(),
    boughtpackages: (json['packages'] as List<dynamic>)
        .map((e) => PackageBought.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$BookingToJson(Booking instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.userfname,
      'last_name': instance.userlname,
      'email': instance.useremail,
      'userid': instance.userid,
      'providerid': instance.providerid,
      'providerfname': instance.providerfname,
      'providerlname': instance.providerlname,
      'provideremail': instance.provideremail,
      'location': instance.location,
      'address': instance.address,
      'total_price': instance.totalprice,
      'boughtpackages': instance.boughtpackages,
    };
