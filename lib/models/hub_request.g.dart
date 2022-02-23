// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hub_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HubRequest _$HubRequestFromJson(Map<String, dynamic> json) => HubRequest(
      json['name'] as String,
      json['description'] as String,
      json['password'] as String,
    );

Map<String, dynamic> _$HubRequestToJson(HubRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'password': instance.password,
    };
