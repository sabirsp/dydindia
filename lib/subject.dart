import 'package:json_annotation/json_annotation.dart';
part 'subject.g.dart';

@JsonSerializable()
class Subject {
  final String sub_id;
  final String exam_id;
  final String subject_name;
  final String subject_code;
  final int freetest;
  final int paidtest;
  final double price;

  Subject(this.exam_id,this.freetest,this.paidtest,this.subject_code,this.sub_id,this.subject_name,this.price);


  factory Subject.fromJson(Map<String, dynamic> json) => _$SubjectFromJson(json);
  Map<String, dynamic> toJson() => _$SubjectToJson(this);
}