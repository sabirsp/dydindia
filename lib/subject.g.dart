// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subject _$SubjectFromJson(Map<String, dynamic> json) {
  return Subject(
    json['exam_id'] as String,
    json['freetest'] as int,
    json['paidtest'] as int,
    json['subject_code'] as String,
    json['sub_id'] as String,
    json['subject_name'] as String,
    (json['price'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$SubjectToJson(Subject instance) => <String, dynamic>{
      'sub_id': instance.sub_id,
      'exam_id': instance.exam_id,
      'subject_name': instance.subject_name,
      'subject_code': instance.subject_code,
      'freetest': instance.freetest,
      'paidtest': instance.paidtest,
      'price': instance.price,
    };
