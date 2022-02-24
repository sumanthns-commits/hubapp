// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hub.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hub _$HubFromJson(Map<String, dynamic> json) => Hub(
      json['hubId'] as String,
      json['description'] as String,
      DateTime.parse(json['createdAt'] as String),
      DateTime.parse(json['updatedAt'] as String),
      (json['things'] as List<dynamic>)
          .map((e) => Thing.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['name'] as String,
    );

Map<String, dynamic> _$HubToJson(Hub instance) => <String, dynamic>{
      'hubId': instance.id,
      'name': instance.name,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'things': instance.things,
    };
