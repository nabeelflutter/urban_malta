import 'package:json_annotation/json_annotation.dart';

part 'chat.g.dart';

@JsonSerializable()
class Chat {
  int senderid;
  String message;

  Chat({
    required this.senderid,
    required this.message,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);

  Map<String, dynamic> toJson() => _$ChatToJson(this);

  /// Connect the generated [_$SignUpToJson] function to the `toJson` method.
}
