// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Resume _$ResumeFromJson(Map<String, dynamic> json) => Resume(
      json['resumeId'] as String?,
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
      json['downloadUrl'] as String?,
      json['pages'] as int,
    )
      ..name = json['name'] as String?
      ..title = json['title'] as String?
      ..location = json['location'] as String?;

Map<String, dynamic> _$ResumeToJson(Resume instance) => <String, dynamic>{
      'resumeId': instance.resumeId,
      'name': instance.name,
      'title': instance.title,
      'location': instance.location,
      'text': instance.text,
      'profile': instance.profile,
      'summary': instance.summary,
      'date': instance.date,
      'downloadUrl': instance.downloadUrl,
      'experiences': instance.experiences,
      'certifications': instance.certifications,
      'pages': instance.pages,
    };

Certification _$CertificationFromJson(Map<String, dynamic> json) =>
    Certification(
      json['certificationId'] as String?,
      json['title'] as String?,
      json['provider'] as String?,
      json['expiryDate'] as String?,
      json['validStart'] as String?,
      json['validEnd'] as String?,
      json['description'] as String?,
    );

Map<String, dynamic> _$CertificationToJson(Certification instance) =>
    <String, dynamic>{
      'certificationId': instance.certificationId,
      'title': instance.title,
      'provider': instance.provider,
      'expiryDate': instance.expiryDate,
      'validStart': instance.validStart,
      'validEnd': instance.validEnd,
      'description': instance.description,
    };

Skill _$SkillFromJson(Map<String, dynamic> json) => Skill(
      json['id'] as int?,
      json['title'] as String?,
    );

Map<String, dynamic> _$SkillToJson(Skill instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };

UserSkill _$UserSkillFromJson(Map<String, dynamic> json) => UserSkill(
      userSkillId: json['userSkillId'] as String?,
      firebaseUserId: json['firebaseUserId'] as String?,
      skill: json['skill'] == null
          ? null
          : Skill.fromJson(json['skill'] as Map<String, dynamic>),
      yearsExperience: json['yearsExperience'] as int?,
      skillLevel: json['skillLevel'] as int?,
      current: json['current'] as bool?,
    );

Map<String, dynamic> _$UserSkillToJson(UserSkill instance) => <String, dynamic>{
      'userSkillId': instance.userSkillId,
      'firebaseUserId': instance.firebaseUserId,
      'yearsExperience': instance.yearsExperience,
      'skillLevel': instance.skillLevel,
      'current': instance.current,
      'skill': instance.skill,
    };
