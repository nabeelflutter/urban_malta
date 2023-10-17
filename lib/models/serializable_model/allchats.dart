import 'package:json_annotation/json_annotation.dart';

part 'allchats.g.dart';

@JsonSerializable()
class AllChats {
  int useroneid;
  String useronename;
  int usertwoid;
  String usertwoname;
  int threadid;
  String message;

  AllChats(
      {required this.useroneid,
      required this.threadid,
      required this.message,
      required this.useronename,
      required this.usertwoid,
      required this.usertwoname});

  factory AllChats.fromJson(Map<String, dynamic> json) =>
      _$AllChatsFromJson(json);

  /// Connect the generated [_$SignUpToJson] function to the `toJson` method.
}
