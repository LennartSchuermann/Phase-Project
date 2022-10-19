// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modul_podo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Modul _$ModulFromJson(Map<String, dynamic> json) => Modul(
      name: json['name'] as String,
      content: (json['content'] as List<dynamic>)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
      phaseCnt: json['phaseCnt'] as int,
    );

Map<String, dynamic> _$ModulToJson(Modul instance) => <String, dynamic>{
      'name': instance.name,
      'phaseCnt': instance.phaseCnt,
      'content': instance.content.map((e) => e.toJson()).toList(),
    };
