// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_podo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      question: json['question'] as String,
      answer: json['answer'] as String,
      imgPath: json['imgPath'] as String,
      phase: json['phase'] as int,
      nextQuery: DateTime.parse(json['nextQuery'] as String),
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'question': instance.question,
      'answer': instance.answer,
      'imgPath': instance.imgPath,
      'phase': instance.phase,
      'nextQuery': instance.nextQuery.toIso8601String(),
    };
