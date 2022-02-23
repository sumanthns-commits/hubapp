// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Thing _$ThingFromJson(Map<String, dynamic> json) => Thing(
      json['thingId'] as String,
      json['description'] as String,
      json['status'] as String,
      DateTime.parse(json['createdAt'] as String),
      DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ThingToJson(Thing instance) => <String, dynamic>{
      'thingId': instance.id,
      'description': instance.description,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
