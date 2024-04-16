import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

import 'job_board.dart';

part 'experience.g.dart';

@JsonSerializable()
class Experience {
  String? id;
  List< String> achievements = [];
  String? company;
  String? startYear, endYear;
  String? description;



  Experience(this.id, this.achievements, this.company, this.startYear,
      this.endYear, this.description);

  factory Experience.fromJson(Map<String, dynamic> json) =>
      _$ExperienceFromJson(json);

  Map<String, dynamic> toJson() => _$ExperienceToJson(this);

}


