// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Job _$JobFromJson(Map<String, dynamic> json) => Job(
      id: json['id'] as String?,
      title: json['title'] as String?,
      company: json['company'] as String?,
      location: json['location'] as String?,
      description: json['description'] as String?,
      date: json['date'] as String?,
      appliedDate: json['appliedDate'] as String?,
      remote: json['remote'] as bool?,
      hybrid: json['hybrid'] as bool?,
      jobBoard: JobBoard.fromJson(json['jobBoard'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$JobToJson(Job instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'company': instance.company,
      'location': instance.location,
      'description': instance.description,
      'date': instance.date,
      'appliedDate': instance.appliedDate,
      'remote': instance.remote,
      'hybrid': instance.hybrid,
      'jobBoard': instance.jobBoard,
    };
