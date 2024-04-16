// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Resume _$ResumeFromJson(Map<String, dynamic> json) => Resume(
      json['id'] as String?,
      json['text'] as String?,
      json['profile'] as String?,
      json['summary'] as String?,
      json['date'] as String?,
      (json['experiences'] as List<dynamic>)
          .map((e) => Experience.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['certifications'] as List<dynamic>)
          .map((e) => Certification.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..name = json['name'] as String?
      ..title = json['title'] as String?
      ..location = json['location'] as String?
      ..skills = (json['skills'] as List<dynamic>)
          .map((e) => Skill.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$ResumeToJson(Resume instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'title': instance.title,
      'location': instance.location,
      'text': instance.text,
      'profile': instance.profile,
      'summary': instance.summary,
      'date': instance.date,
      'experiences': instance.experiences,
      'certifications': instance.certifications,
      'skills': instance.skills,
    };

Certification _$CertificationFromJson(Map<String, dynamic> json) =>
    Certification(
      json['id'] as String?,
      json['title'] as String?,
      json['provider'] as String?,
      json['expiryDate'] as String?,
      json['validStart'] as String?,
      json['validEnd'] as String?,
      json['description'] as String?,
    );

Map<String, dynamic> _$CertificationToJson(Certification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'provider': instance.provider,
      'expiryDate': instance.expiryDate,
      'validStart': instance.validStart,
      'validEnd': instance.validEnd,
      'description': instance.description,
    };

Skill _$SkillFromJson(Map<String, dynamic> json) => Skill(
      json['id'] as String?,
      json['title'] as String?,
      json['yearsExperience'] as int?,
      json['skillLevel'] as int?,
      json['current'] as bool?,
    );

Map<String, dynamic> _$SkillToJson(Skill instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'yearsExperience': instance.yearsExperience,
      'skillLevel': instance.skillLevel,
      'current': instance.current,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['id'] as String?,
      json['name'] as String?,
      json['email'] as String?,
      json['date'] as String?,
      json['password'] as String?,
      json['updated'] as String?,
      json['active'] as bool?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'date': instance.date,
      'password': instance.password,
      'updated': instance.updated,
      'active': instance.active,
    };
