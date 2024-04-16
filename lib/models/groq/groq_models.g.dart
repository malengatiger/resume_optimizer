// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'groq_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroqRequest _$GroqRequestFromJson(Map<String, dynamic> json) => GroqRequest(
      content: json['content'] as String?,
      role: json['role'] as String?,
      name: json['name'] as String?,
      seed: json['seed'] as int?,
      temperature: (json['temperature'] as num?)?.toDouble(),
      topP: (json['top_p'] as num?)?.toDouble(),
      stop: json['stop'] as String?,
    )..stream = json['stream'] as bool?;

Map<String, dynamic> _$GroqRequestToJson(GroqRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('content', instance.content);
  writeNotNull('role', instance.role);
  writeNotNull('name', instance.name);
  writeNotNull('seed', instance.seed);
  writeNotNull('temperature', instance.temperature);
  writeNotNull('top_p', instance.topP);
  writeNotNull('stream', instance.stream);
  writeNotNull('stop', instance.stop);
  return val;
}
