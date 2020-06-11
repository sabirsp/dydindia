

import 'package:dydindia/design/test_card.dart';
import 'package:dydindia/subject.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
part 'all_exams.g.dart';

@JsonSerializable(explicitToJson: true)
class Exam {
  final String exam_name;
  final String exam_image;
  final String exam_id;
  final int subjectcount;
  final List<Subject> subjects;


  Exam(this.exam_name,this.exam_image,this.exam_id,this.subjectcount,this.subjects);

  factory Exam.fromJson(Map<String, dynamic> json) => _$ExamFromJson(json);
  Map<String, dynamic> toJson() => _$ExamToJson(this);
}



List<Exam> parseExams(String responseBody) {
  final parsed = jsonDecode(responseBody);

  return parsed.map<Exam>((json) => Exam.fromJson(json)).toList();
}

Future<List<Exam>> fetchExams(http.Client client) async {
  final response =
  await client.get('http://dydindia.com/admin/examlist/getallexam');



  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseExams, response.body);
}

class AllExams extends StatefulWidget {
  final examData;
  AllExams({this.examData});
  @override
  _AllExamsState createState() => _AllExamsState();
}

class _AllExamsState extends State<AllExams> {

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text('List of Exams'),
        backgroundColor: Colors.purple,
        elevation: 30,
      ),
      body: FutureBuilder<List<Exam>>(
        future: fetchExams(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? ExamsList(exams: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}


class ExamsList extends StatelessWidget {
  final List<Exam> exams;

  ExamsList({Key key, this.exams}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(

      itemCount: exams.length,
      itemBuilder: (context, index) {

        return TestCard(
          exam_image: exams[index].exam_image=='' || exams[index].exam_image==null ? NetworkImage('http://dydindia.com/admin/image/no-image.png') :NetworkImage('http://dydindia.com/admin/image/'+exams[index].exam_image),
          exam_name: exams[index].exam_name ,
          subjectcount: exams[index].subjectcount,
          exam_id: exams[index].exam_id,
          subjects: exams[index].subjects,

        );
      },
    );
  }
}
