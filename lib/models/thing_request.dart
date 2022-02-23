import 'package:json_annotation/json_annotation.dart';
part 'thing_request.g.dart';

@JsonSerializable()
class ThingRequest {
  final String name;
  final String description;

  ThingRequest(this.name, this.description);

  factory ThingRequest.fromJson(Map<String, dynamic> json) =>
      _$ThingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ThingRequestToJson(this);
}
