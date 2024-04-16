// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'groq_chat_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroqChatResponse _$GroqChatResponseFromJson(Map<String, dynamic> json) =>
    GroqChatResponse(
      id: json['id'] as String?,
      object: json['object'] as String?,
      created: json['created'] as int?,
      model: json['model'] as String?,
      systemFingerprint: json['system_fingerprint'],
      choices: (json['choices'] as List<dynamic>?)
          ?.map((e) => Choices.fromJson(e as Map<String, dynamic>))
          .toList(),
      usage: json['usage'] == null
          ? null
          : Usage.fromJson(json['usage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GroqChatResponseToJson(GroqChatResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'created': instance.created,
      'model': instance.model,
      'system_fingerprint': instance.systemFingerprint,
      'choices': instance.choices?.map((e) => e.toJson()).toList(),
      'usage': instance.usage?.toJson(),
    };

Choices _$ChoicesFromJson(Map<String, dynamic> json) => Choices(
      index: json['index'] as int?,
      message: json['message'] == null
          ? null
          : Message.fromJson(json['message'] as Map<String, dynamic>),
      finishReason: json['finish_reason'] as String?,
    );

Map<String, dynamic> _$ChoicesToJson(Choices instance) => <String, dynamic>{
      'index': instance.index,
      'message': instance.message?.toJson(),
      'finish_reason': instance.finishReason,
    };

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      role: json['role'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'role': instance.role,
      'content': instance.content,
    };

Usage _$UsageFromJson(Map<String, dynamic> json) => Usage(
      promptTokens: json['prompt_tokens'] as int?,
      completionTokens: json['completion_tokens'] as int?,
      totalTokens: json['total_tokens'] as int?,
      promptTime: (json['prompt_time'] as num?)?.toDouble(),
      completionTime: (json['completion_time'] as num?)?.toDouble(),
      totalTime: (json['total_time'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$UsageToJson(Usage instance) => <String, dynamic>{
      'prompt_tokens': instance.promptTokens,
      'completion_tokens': instance.completionTokens,
      'total_tokens': instance.totalTokens,
      'prompt_time': instance.promptTime,
      'completion_time': instance.completionTime,
      'total_time': instance.totalTime,
    };
