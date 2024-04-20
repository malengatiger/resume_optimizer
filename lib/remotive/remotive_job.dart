import 'dart:core';

import 'package:json_annotation/json_annotation.dart';


part 'remotive_job.g.dart';

@JsonSerializable()
class RemotiveJob {
  int? id;
  String? title;
  @JsonKey(name: 'company_name')
  String? company;
  @JsonKey(name: 'company_logo')
  String? companyLogo;
  String? url;
  String? category;
  @JsonKey(name: 'job_type')
  String? jobType;
  @JsonKey(name: 'publication_date')
  String? publicationDate;
  @JsonKey(name: 'candidate_required_location')
  String? candidateRequiredLocation;
  String? appliedDate;
  bool? remote, hybrid;
  String? description, salary;   //description is html string ....
  List? tags;


  RemotiveJob({
      required this.id,
      required this.title,
      required this.company,
      required this.companyLogo,
      required this.url,
      required this.category,
      required this.jobType,
      required this.publicationDate,
      required this.candidateRequiredLocation,
      required this.appliedDate,
      required this.remote,
      required this.hybrid,
      required this.description,
      required this.salary,
      required this.tags});

  factory RemotiveJob.fromJson(Map<String, dynamic> json) =>
      _$RemotiveJobFromJson(json);

  Map<String, dynamic> toJson() => _$RemotiveJobToJson(this);
  setRemote() {
    remote = true;
    hybrid = false;
  }
  setHybrid() {
    remote = false;
    hybrid = true;
  }
}


