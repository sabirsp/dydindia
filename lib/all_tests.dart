

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'loading_test_paper.dart';
import 'all_test_list.dart';

part 'all_tests.g.dart';

@JsonSerializable()
class Test {

  final int serial_no;
  final String paper_id;
  final String duration_min;
  final String price;


  Test(this.serial_no,this.price,this.paper_id,this.duration_min);

  factory Test.fromJson(Map<String, dynamic> json) => _$TestFromJson(json);
  Map<String, dynamic> toJson() => _$TestToJson(this);
}



List<Test> parseTests(String responseBody) {
  final parsed = jsonDecode(responseBody);

  return parsed.map<Test>((json) => Test.fromJson(json)).toList();
}

Future<List<Test>> fetchTests(http.Client client, String sub_id, String exam_id) async {
  final response =
  await client.get('http://dydindia.com/admin/api/getquestionpaper/?&sub_id=$sub_id&exam_id=$exam_id');



  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseTests, response.body);
}

Future<List<Test>> fetchFreeTests(http.Client client, String sub_id, String exam_id) async {
  final response =
  await client.get('http://dydindia.com/admin/api/freepaperlist/?&sub_id=$sub_id&exam_id=$exam_id');



  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseTests, response.body);
}






String twoDigits(int n){
  if(n < 10)
    return '0$n';
  else
    return '$n';
}

class AllTests extends StatefulWidget {
  final String sub_id;
  final ImageProvider exam_image;
  final String exam_name;
  final String subject_name;
  final String exam_id;
  AllTests({this.sub_id,this.exam_name,this.subject_name,this.exam_image,this.exam_id});
  @override
  _AllTestsState createState() => _AllTestsState();
}

class _AllTestsState extends State<AllTests> with AutomaticKeepAliveClientMixin {
  int currentIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold (
      appBar: AppBar(

        leading: Image(
          image: widget.exam_image,
          width: 70,
          height: 60,
        ),
        title: Column(
          children: <Widget>[
            Text(widget.exam_name,style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              color: Colors.white,
            ),),
            SizedBox(height: 5.0,),
            Text(widget.subject_name,style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              color: Colors.white70,
            ),),
          ],
        ),
        backgroundColor: Colors.purple,
        elevation: 3,



      ),
      endDrawer: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Material(

          elevation: 10.0,
          shape: CircleBorder(),
          child: Container(
            margin: EdgeInsets.only(right: 15.0),
            height: MediaQuery.of(context).size.height - 200,
            width: MediaQuery.of(context).size.width - 100,


          ),
        ),
      ),

      body: AllTestList(
        sub_id: widget.sub_id,
        exam_id: widget.exam_id,
        subject_name: widget.subject_name,
      )


    );
  }
}


class TestsList extends StatelessWidget {
  final List<Test> tests;
  final String subject_name;

  TestsList({Key key, this.tests,this.subject_name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(

      itemCount: tests.length,
      itemBuilder: (context, index) {

        return

          Card(
            elevation: 3.0,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: double.parse(tests[index].price) <=0? Colors.green : Colors.redAccent,
                    child: Text( twoDigits(tests[index].serial_no),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold
                      ) ,),
                  ),
                  SizedBox(width: 10.0,),
                  Expanded(
                    child: Text('$subject_name - Mock Test ${twoDigits(tests[index].serial_no)}' ,
                    style: TextStyle(
                      color: Colors.cyan,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,),
                  ),
                  SizedBox(width: 10.0,),
                  RaisedButton(
                    onPressed: (){
                      print(tests[index].paper_id);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context){
                          print(tests[index].duration_min);
                          return LoadingTestPaper(
                            paper_id: tests[index].paper_id,
                            duration: tests[index].duration_min,
                          );
                        }
                      ));
                    },
                    color: Colors.blue.shade700,
                    child: double.parse(tests[index].price) <=0? Row(children: <Widget>[
                      Text('Start', style: TextStyle(color: Colors.white),),
                      Icon(Icons.play_arrow, color: Colors.white,),
                    ],) :
                    Container(
                      child: Row(
                        children: <Widget>[
                          Text('Buy @ ',style: TextStyle(color: Colors.white),),
                          Icon(FontAwesomeIcons.rupeeSign, color: Colors.white,size: 14.0,),
                          Text(tests[index].price,style: TextStyle(color: Colors.white),),
                        ]
                      ),
                    )
                  ),

                ],
              ),
            ),
          );



        /*  TestCard(
          exam_image: NetworkImage('http://dydindia.com/admin/image/'+exams[index].exam_image),
          exam_name: tests[index].exam_name ,
          subjectcount: tests[index].subjectcount,
          exam_id: tests[index].exam_id,
          subjects: tests[index].subjects,
        );*/
      },
    );
  }
}
