import 'package:json_annotation/json_annotation.dart';

part 'thing.g.dart';

@JsonSerializable()
class Thing {
  static const String ON = 'on';
  static const String OFF = 'off';

  @JsonKey(name: "thingId")
  final String id;

  final String name;

  final String description;

  String status;

  final DateTime createdAt;

  final DateTime updatedAt;

  Thing(this.id, this.description, this.status, this.createdAt, this.updatedAt,
      this.name);

  factory Thing.fromJson(Map<String, dynamic> json) => _$ThingFromJson(json);

  Map<String, dynamic> toJson() => _$ThingToJson(this);

  bool isOn() {
    return status == ON;
  }

  void updateState(bool newValue) {
    if (newValue != isOn()) {
      this.status = newValue ? ON : OFF;
    }
  }
}
