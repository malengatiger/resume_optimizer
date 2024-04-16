import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

import 'experience.dart';
import 'job.dart';
import 'job_board.dart';

part 'resume.g.dart';

@JsonSerializable()
class Resume {
  String? id;
  String? name, title, location, text;
  String? profile;
  String? summary;
  String? date;
  List<Experience> experiences = [];
  List<Certification> certifications = [];
  List<Skill> skills = [];


  Resume(this.id, this.text, this.profile, this.summary,
      this.date,this.experiences, this.certifications);

  factory Resume.fromJson(Map<String, dynamic> json) =>
      _$ResumeFromJson(json);

  Map<String, dynamic> toJson() => _$ResumeToJson(this);

}

@JsonSerializable()
class Certification {
  String? id;
  String? title;
  String? provider;
  String? expiryDate;
  String? validStart, validEnd, description;

  Certification(this.id, this.title, this.provider, this.expiryDate,
      this.validStart, this.validEnd, this.description);
  factory Certification.fromJson(Map<String, dynamic> json) =>
      _$CertificationFromJson(json);

  Map<String, dynamic> toJson() => _$CertificationToJson(this);

}

@JsonSerializable()
class Skill {
  String? id;
  String? title;
  int? yearsExperience;
  int? skillLevel;
  bool? current;


  Skill(this.id, this.title, this.yearsExperience, this.skillLevel, this.current);

  factory Skill.fromJson(Map<String, dynamic> json) =>
      _$SkillFromJson(json);

  Map<String, dynamic> toJson() => _$SkillToJson(this);

}

@JsonSerializable()
class User {
  String? id;
  String? name, email, date, password, updated;
  bool? active;


  User(this.id, this.name, this.email, this.date, this.password, this.updated,
      this.active);

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

}



