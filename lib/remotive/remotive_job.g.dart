// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remotive_job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemotiveJob _$RemotiveJobFromJson(Map<String, dynamic> json) => RemotiveJob(
      id: json['id'] as int?,
      title: json['title'] as String?,
      company: json['company_name'] as String?,
      companyLogo: json['company_logo'] as String?,
      url: json['url'] as String?,
      category: json['category'] as String?,
      jobType: json['job_type'] as String?,
      publicationDate: json['publication_date'] as String?,
      candidateRequiredLocation: json['candidate_required_location'] as String?,
      appliedDate: json['appliedDate'] as String?,
      remote: json['remote'] as bool?,
      hybrid: json['hybrid'] as bool?,
      description: json['description'] as String?,
      salary: json['salary'] as String?,
      tags: json['tags'] as List<dynamic>?,
    );

Map<String, dynamic> _$RemotiveJobToJson(RemotiveJob instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'company_name': instance.company,
      'company_logo': instance.companyLogo,
      'url': instance.url,
      'category': instance.category,
      'job_type': instance.jobType,
      'publication_date': instance.publicationDate,
      'candidate_required_location': instance.candidateRequiredLocation,
      'appliedDate': instance.appliedDate,
      'remote': instance.remote,
      'hybrid': instance.hybrid,
      'description': instance.description,
      'salary': instance.salary,
      'tags': instance.tags,
    };
