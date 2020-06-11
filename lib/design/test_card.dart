import 'dart:ui';

import 'package:dydindia/all_tests.dart';
import 'package:flutter/material.dart';
import 'package:dydindia/subject.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TestCard extends StatelessWidget {
  TestCard({this.exam_image, this.exam_name, this.subjects, this.subjectcount,this.exam_id});
  final String exam_name;
  final ImageProvider exam_image;
  final String exam_id;
  final int subjectcount;
  final List<Subject> subjects;


  List<Widget> subjectUI(BuildContext context) {
    List<Widget> list = [];

    for (int i = 0; i < subjects.length; i++) {
      int total_test = subjects[i].freetest + subjects[i].paidtest;
      Widget text = FlatButton(
        onPressed: (){
          if(total_test > 0){
            Navigator.push(context, MaterialPageRoute(
              builder: (context){
                return AllTests(
                  subject_name: subjects[i].subject_name,
                  exam_id: exam_id,
                  exam_name: exam_name,
                  sub_id: subjects[i].sub_id,
                  exam_image: exam_image,
                );
              }
            ));
          }
          else{
            showDialog(context: context,
            barrierDismissible: true,
            builder: (BuildContext context){
                return AlertDialog(
                  title: Container(
                      width: 250,
                      height: 150,
                      child: Center(child: Text('Tests are coming soon...',textAlign: TextAlign.center,),),),
                  elevation: 25.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),

                );
            },
          );
          }
        },
        child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    subjects[i].subject_name,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '$total_test ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        total_test>1 ? 'Total Tests | ' : 'Total Test | ',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        '${subjects[i].freetest}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        subjects[i].freetest >1 ? ' Free Tests' : ' Free Test',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

      );


      list.add(text);
      list.add(
        SizedBox(
          height: 5.0,
        ),
      );
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 30,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Image(
              image: exam_image,
              width: 80,
              height: 80,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              exam_name,
              style: TextStyle(
                color: Colors.green.shade900,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Divider(
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: subjects != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: subjectUI(context),
                    )
                  : Text(
                      'Tests are coming soon...',
                      style: TextStyle(
                        color: Colors.cyan,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
