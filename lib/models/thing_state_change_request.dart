import 'package:json_annotation/json_annotation.dart';
part 'thing_state_change_request.g.dart';

@JsonSerializable()
class ThingStateChangeRequest {
  final String status;

  ThingStateChangeRequest(this.status);

  factory ThingStateChangeRequest.fromValue(bool value) =>
      ThingStateChangeRequest(value ? 'on' : 'off');

  factory ThingStateChangeRequest.fromJson(Map<String, dynamic> json) =>
      _$ThingStateChangeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ThingStateChangeRequestToJson(this);
}
