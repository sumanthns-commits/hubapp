import 'package:hubapp/models/thing.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hub.g.dart';

@JsonSerializable()
class Hub {
  @JsonKey(name: "hubId")
  final String id;

  final String description;

  final String status;

  final DateTime createdAt;

  final DateTime updatedAt;

  final List<Thing> things;

  Hub(this.id, this.description, this.status, this.createdAt, this.updatedAt,
      this.things);

  factory Hub.fromJson(Map<String, dynamic> json) => _$HubFromJson(json);

  Map<String, dynamic> toJson() => _$HubToJson(this);
}
