import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

import 'experience.dart';

part 'resume.g.dart';

@JsonSerializable()
class Resume {
  String? resumeId;
  String? name, title, location, text;
  String? profile;
  String? summary;
  String? date, downloadUrl;
  List<Experience> experiences = [];
  List<Certification> certifications = [];
  int pages;

  Resume(this.resumeId, this.text, this.profile, this.summary, this.date,
      this.experiences, this.certifications, this.downloadUrl, this.pages);

  factory Resume.fromJson(Map<String, dynamic> json) => _$ResumeFromJson(json);

  Map<String, dynamic> toJson() => _$ResumeToJson(this);
}

@JsonSerializable()
class Certification {
  String? certificationId;
  String? title;
  String? provider;
  String? expiryDate;
  String? validStart, validEnd, description;

  Certification(this.certificationId, this.title, this.provider,
      this.expiryDate, this.validStart, this.validEnd, this.description);

  factory Certification.fromJson(Map<String, dynamic> json) =>
      _$CertificationFromJson(json);

  Map<String, dynamic> toJson() => _$CertificationToJson(this);
}

@JsonSerializable()
class Skill {
  int? id;
  String? title;

  Skill(
    this.id,
    this.title,
  );

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);

  Map<String, dynamic> toJson() => _$SkillToJson(this);
}

@JsonSerializable()
class UserSkill {
  String? userSkillId;
  String? firebaseUserId;
  int? yearsExperience;
  int? skillLevel;
  bool? current;
  Skill? skill;

  UserSkill(
      {required this.userSkillId,
      required this.firebaseUserId,
      required this.skill,
      required this.yearsExperience,
      required this.skillLevel,
      required this.current});

  factory UserSkill.fromJson(Map<String, dynamic> json) =>
      _$UserSkillFromJson(json);

  Map<String, dynamic> toJson() => _$UserSkillToJson(this);
}
