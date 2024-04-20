import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pretty_json/pretty_json.dart';
import 'package:resume_optimizer/services/dio_util.dart';

import '../models/job.dart';
import '../remotive/remotive_job.dart';
import '../util/functions.dart';

class RemotiveService {
  static const prefix = 'https://remotive.com/api/remote-jobs';
  static const acceleratorPrefix = 'https://remotive.com/jobs-accelerator/';

  //https://remotive.com/jobs-accelerator/software-development?locations=South%20Africa%2BGermany&skills=java%2Bspring%20boot
  /*
https://remotive.com/jobs-accelerator/software-development?
locations=South%20Africa%2BGermany
%2BSpain&
skills=java
%2Bspring%20boot
%2Bdocker
%2Baws&
lang=en&
seniority=senior%2Bmid-level
 */
  final DioUtil dioUtil;
  static const mm = '🌼🌼🌼RemotiveService 🌼🌼🌼';

  RemotiveService(this.dioUtil);

  Future<List<RemotiveJob>> fetchJobs(
      {required String? category,
      required List<String>? locations,
      required List<String>? skills,
      bool? fromAccelerator}) async {
    var locationsBuffer = StringBuffer();
    var skillsBuffer = StringBuffer();
    List<RemotiveJob> remotiveJobs = [];
    if (category == null || category.isEmpty) {
      category = myCategory;
    }
    if (skills == null || skills.isEmpty) {
      skills = mySkills;
    }
    if (locations == null || locations.isEmpty) {
      locations = myLocations;
    }

    var index = 0;
    for (var element in locations) {
      locationsBuffer.write(element);
      if (locations.length > 1 && index < locations.length) {
        locationsBuffer.write('+');
      }
      index++;
    }
    index = 0;
    for (var element in skills) {
      skillsBuffer.write(element);
      if (skills.length > 1 && index < skills.length) {
        skillsBuffer.write('+');
      }
      index++;
    }
    var mLocations =
        locations.length == 1 ? locations.first : locationsBuffer.toString();
    var mSkills = skills.length == 1 ? skills.first : skillsBuffer.toString();

    pp('$mm will work from locations: $mLocations and skills: $mSkills');
    var url = fromAccelerator == true ? acceleratorPrefix : prefix;
    pp('$mm url: $url');

    mLocations = Uri.encodeFull(mLocations); // Use Uri.encodeFull to encode the URL

    mSkills = Uri.encodeFull(mSkills); // Use Uri.encodeFull to encode the URL
    pp('$mm will work from locations: $mLocations and 🦠skills: $mSkills 🦠');

    Response resp = await dioUtil.sendGetRequest(path: url, params: {
      'category': category,
      // 'locations': mLocations,
      // 'skills': mSkills,
    });
    List jobs = resp.data['jobs'];
    for (var job in jobs) {
      var remJob = RemotiveJob.fromJson(job);
      remotiveJobs.add(remJob);
      // pp('$mm job: ${prettyJson(remJob.toJson())}');
    }
    pp('\n\n$mm Response: statusCode: ${resp.statusCode} '
        '- JOB COUNT:${remotiveJobs.length}  $mm');
    return remotiveJobs;
  }

  List<String> mySkills = [
    'Google Cloud Platform',
    'AWS',
    'AI Chatbot Developing using OpenAI, Gemini, Claude, Groq and Mistral',
    'Java with Springboot',
  ];
  List<String> myLocations = ['South Africa'];
  static const myCategory = 'software-dev';
}

