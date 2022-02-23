import 'package:json_annotation/json_annotation.dart';
part 'hub_request.g.dart';

@JsonSerializable()
class HubRequest {
  final String name;
  final String description;
  final String password;

  HubRequest(this.name, this.description, this.password);

  factory HubRequest.fromJson(Map<String, dynamic> json) =>
      _$HubRequestFromJson(json);

  Map<String, dynamic> toJson() => _$HubRequestToJson(this);
}
