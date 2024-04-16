// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experience.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Experience _$ExperienceFromJson(Map<String, dynamic> json) => Experience(
      json['id'] as String?,
      (json['achievements'] as List<dynamic>).map((e) => e as String).toList(),
      json['company'] as String?,
      json['startYear'] as String?,
      json['endYear'] as String?,
      json['description'] as String?,
    );

Map<String, dynamic> _$ExperienceToJson(Experience instance) =>
    <String, dynamic>{
      'id': instance.id,
      'achievements': instance.achievements,
      'company': instance.company,
      'startYear': instance.startYear,
      'endYear': instance.endYear,
      'description': instance.description,
    };
