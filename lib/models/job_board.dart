import 'dart:core';
import 'dart:core';

import 'package:json_annotation/json_annotation.dart';
part 'job_board.g.dart';
@JsonSerializable()
class JobBoard {
  String? id;
  String? name;
  String? url;

  JobBoard(this.id, this.name, this.url);

  factory JobBoard.fromJson(Map<String, dynamic> json) =>
      _$JobBoardFromJson(json);

  Map<String, dynamic> toJson() => _$JobBoardToJson(this);
}

