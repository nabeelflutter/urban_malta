import 'package:json_annotation/json_annotation.dart';

part 'thread_id.g.dart';

@JsonSerializable()
class Thread{
  int id;
  Thread({
    required this.id,
  });


  factory Thread.fromJson(Map<String, dynamic> json) =>
      _$ThreadFromJson(json);

  /// Connect the generated [_$SignUpToJson] function to the `toJson` method.


}