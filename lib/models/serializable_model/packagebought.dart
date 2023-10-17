import 'package:json_annotation/json_annotation.dart';
import 'package:kappu/models/serializable_model/offer_package.dart';
part 'packagebought.g.dart';

@JsonSerializable()
class PackageBought {
//  @JsonKey(name: 'id')
  Offerpackage package;
  @JsonKey(name: 'quantity')
  String quantity;

  @JsonKey(name: 'price')
  String price;

  PackageBought(
      {required this.package, required this.quantity, required this.price});

  factory PackageBought.fromJson(Map<String, dynamic> json) =>
      _$PackageBoughtFromJson(json);

  /// Connect the generated [_$SignInToJson] function to the `toJson` method.

  Map<String, dynamic> toJson() => _$PackageBoughtToJson(this);
}
