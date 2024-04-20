import 'dart:core';

import 'package:json_annotation/json_annotation.dart';
import 'package:resume_optimizer/models/resume.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String? firebaseUserId;
  String? name;
  String? email;
  String? password;
  String? date;
  List<Skill> skills = [];

  User(
      {required this.firebaseUserId,
      required this.name,
      required this.email,
       this.password,
      required this.date,
      required this.skills});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
