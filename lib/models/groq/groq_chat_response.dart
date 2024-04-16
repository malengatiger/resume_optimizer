import 'package:json_annotation/json_annotation.dart';

part 'groq_chat_response.g.dart';

@JsonSerializable(explicitToJson: true)
class GroqChatResponse {
  final String? id;
  final String? object;
  final int? created;
  final String? model;
  @JsonKey(name: 'system_fingerprint')
  final dynamic systemFingerprint;
  final List<Choices>? choices;
  final Usage? usage;

  const GroqChatResponse({
    this.id,
    this.object,
    this.created,
    this.model,
    this.systemFingerprint,
    this.choices,
    this.usage,
  });

  factory GroqChatResponse.fromJson(Map<String, dynamic> json) =>
      _$GroqChatResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GroqChatResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Choices {
  final int? index;
  final Message? message;
  @JsonKey(name: 'finish_reason')
  final String? finishReason;

  const Choices({
    this.index,
    this.message,
    this.finishReason,
  });

  factory Choices.fromJson(Map<String, dynamic> json) =>
      _$ChoicesFromJson(json);

  Map<String, dynamic> toJson() => _$ChoicesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Message {
  final String? role;
  final String? content;

  const Message({
    this.role,
    this.content,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Usage {
  @JsonKey(name: 'prompt_tokens')
  final int? promptTokens;
  @JsonKey(name: 'completion_tokens')
  final int? completionTokens;
  @JsonKey(name: 'total_tokens')
  final int? totalTokens;
  @JsonKey(name: 'prompt_time')
  final double? promptTime;
  @JsonKey(name: 'completion_time')
  final double? completionTime;
  @JsonKey(name: 'total_time')
  final double? totalTime;


  const Usage({
    this.promptTokens,
    this.completionTokens,
    this.totalTokens,
    this.promptTime,
    this.completionTime,
    this.totalTime,
  });

  factory Usage.fromJson(Map<String, dynamic> json) =>
      _$UsageFromJson(json);

  Map<String, dynamic> toJson() => _$UsageToJson(this);
}
