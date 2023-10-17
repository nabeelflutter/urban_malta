// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allchats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllChats _$AllChatsFromJson(Map<String, dynamic> json) {
  return AllChats(
    useroneid: json['user_one']['id'] as int,
    useronename: json['user_one']['first_name'] +
        " " +
        json['user_one']['last_name'] as String,
    usertwoid: json['user_two']['id'] as int,
    threadid: json['message']['thread'] as int,
    message: json['message']['message'] as String,
    usertwoname: json['user_two']['first_name'] +
        " " +
        json['user_two']['last_name'] as String,
  );
}
