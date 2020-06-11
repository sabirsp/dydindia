import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'all_tests.dart';
class AllTestList extends StatefulWidget {
  final String sub_id;
  final String exam_id;
  final String subject_name;

  AllTestList({ this.sub_id, this.exam_id, this.subject_name}) ;


  @override
  _FreeTestListState createState() => _FreeTestListState();
}

class _FreeTestListState extends State<AllTestList>   {

  Future<List<Test>> _loadingAllTest;




  @override
  void initState(){
    _loadingAllTest = fetchTests(http.Client(), widget.sub_id, widget.exam_id);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadingAllTest,
      builder: (BuildContext context, snapshot){
        if (snapshot.hasError) print(snapshot.error);




          return snapshot.hasData
              ? TestsList(tests: snapshot.data, subject_name: widget.subject_name,)
              : Center(child: CircularProgressIndicator());




      },
    );
  }






}
