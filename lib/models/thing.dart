import 'package:json_annotation/json_annotation.dart';

part 'thing.g.dart';

@JsonSerializable()
class Thing {
  @JsonKey(name: "thingId")
  final String id;

  final String description;

  final String status;

  final DateTime createdAt;

  final DateTime updatedAt;

  Thing(this.id, this.description, this.status, this.createdAt, this.updatedAt);

  factory Thing.fromJson(Map<String, dynamic> json) =>
      _$ThingFromJson(json);

  Map<String, dynamic> toJson() => _$ThingToJson(this);
}
