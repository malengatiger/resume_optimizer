import 'dart:core';

import 'package:json_annotation/json_annotation.dart';
import 'package:resume_optimizer/models/resume.dart';

import 'job.dart';
import 'job_board.dart';

part 'application.g.dart';

@JsonSerializable()
class Application {
  String? id;
  String? date;
  String? remarks, response;
  Job? job;
  Resume? resume;

  String? coverLetter;

  Application(
      this.id, this.date, this.remarks, this.response, this.job, this.resume, this.coverLetter);

  factory Application.fromJson(Map<String, dynamic> json) =>
      _$ApplicationFromJson(json);

  Map<String, dynamic> toJson() => _$ApplicationToJson(this);

}


