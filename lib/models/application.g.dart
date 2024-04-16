// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Application _$ApplicationFromJson(Map<String, dynamic> json) => Application(
      json['id'] as String?,
      json['date'] as String?,
      json['remarks'] as String?,
      json['response'] as String?,
      json['job'] == null
          ? null
          : Job.fromJson(json['job'] as Map<String, dynamic>),
      json['resume'] == null
          ? null
          : Resume.fromJson(json['resume'] as Map<String, dynamic>),
      json['coverLetter'] as String?,
    );

Map<String, dynamic> _$ApplicationToJson(Application instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'remarks': instance.remarks,
      'response': instance.response,
      'job': instance.job,
      'resume': instance.resume,
      'coverLetter': instance.coverLetter,
    };
