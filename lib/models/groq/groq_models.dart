import 'package:json_annotation/json_annotation.dart';

part 'groq_models.g.dart';

//role: system, user, assistant
@JsonSerializable(includeIfNull: false)
class GroqRequest {
  String? content;
  String? role;
  String? name;
  int? seed;
  double? temperature;
  @JsonKey(name: 'top_p', includeIfNull: false)
  double? topP;
  bool? stream;
  String? stop;


  GroqRequest(
      {required this.content,
      required this.role,
      this.name,
      this.seed,
      this.temperature,
      this.topP,
      this.stop});

  factory GroqRequest.fromJson(Map<String, dynamic> json) =>
      _$GroqRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GroqRequestToJson(this);
}
