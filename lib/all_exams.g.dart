// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_exams.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exam _$ExamFromJson(Map<String, dynamic> json) {
  return Exam(
    json['exam_name'] as String,
    json['exam_image'] as String,
    json['exam_id'] as String,
    json['subjectcount'] as int,
    (json['subjects'] as List)
        ?.map((e) =>
            e == null ? null : Subject.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ExamToJson(Exam instance) => <String, dynamic>{
      'exam_name': instance.exam_name,
      'exam_image': instance.exam_image,
      'exam_id': instance.exam_id,
      'subjectcount': instance.subjectcount,
      'subjects': instance.subjects?.map((e) => e?.toJson())?.toList(),
    };
