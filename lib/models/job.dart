import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

import 'job_board.dart';

part 'job.g.dart';

@JsonSerializable()
class Job {
  String? id;
  String? title;
  String? company;
  String? location;
  String? description;
  String? date;
  String? appliedDate;
  bool? remote, hybrid;
  JobBoard jobBoard;

  Job(
      {required this.id,
      required this.title,
      required this.company,
      required this.location,
      required this.description,
      required this.date,
      required this.appliedDate,
      required this.remote,
      required this.hybrid,
      required this.jobBoard});

  factory Job.fromJson(Map<String, dynamic> json) =>
      _$JobFromJson(json);

  Map<String, dynamic> toJson() => _$JobToJson(this);
  setRemote() {
    remote = true;
    hybrid = false;
  }
  setHybrid() {
    remote = false;
    hybrid = true;
  }
}


