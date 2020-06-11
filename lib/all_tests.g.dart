// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_tests.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Test _$TestFromJson(Map<String, dynamic> json) {
  return Test(
    json['serial_no'] as int,
    json['price'] as String,
    json['paper_id'] as String,
    json['duration_min'] as String,
  );
}

Map<String, dynamic> _$TestToJson(Test instance) => <String, dynamic>{
      'serial_no': instance.serial_no,
      'paper_id': instance.paper_id,
      'duration_min': instance.duration_min,
      'price': instance.price,
    };
