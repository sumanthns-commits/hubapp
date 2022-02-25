import 'package:hubapp/models/thing.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

part 'hub.g.dart';

@JsonSerializable()
class Hub {
  @JsonKey(name: "hubId")
  final String id;

  final String name;

  final String description;

  final DateTime createdAt;

  final DateTime updatedAt;

  late List<Thing> _things;

  List<Thing> get things => List.unmodifiable(_things);

  Hub(this.id, this.name, this.description, this.createdAt, this.updatedAt,
      List<Thing> things) {
    _things = things;
  }

  factory Hub.fromJson(Map<String, dynamic> json) => _$HubFromJson(json);

  Map<String, dynamic> toJson() => _$HubToJson(this);

  void addThing(Thing thing) {
    _things.add(thing);
  }

  void updateThingState(String thingId, bool newValue) {
    Thing? thing = _things.firstWhereOrNull((element) => element.id == thingId);
    if (thing != null) {
      thing.updateState(newValue);
    }
  }
}
