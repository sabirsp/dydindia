import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'all_tests.dart';
class FreeTestList extends StatefulWidget {
  final String sub_id;
  final String exam_id;
  final String subject_name;

   FreeTestList({ this.sub_id, this.exam_id, this.subject_name}) ;


  @override
  _FreeTestListState createState() => _FreeTestListState();
}

class _FreeTestListState extends State<FreeTestList> with AutomaticKeepAliveClientMixin {

  Future<List<Test>> _loadingFreeTest;




  @override
  void initState(){
    _loadingFreeTest = fetchFreeTests(http.Client(), widget.sub_id, widget.exam_id);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadingFreeTest,
      builder: (BuildContext context, snapshot){
        if (snapshot.hasError) print(snapshot.error);


        if(snapshot.data == null){
          return Container(
            child: Center(
              child: Text('NO Tests Available'),
            ) ,
          );
        }
        else{

          return snapshot.hasData
              ? TestsList(tests: snapshot.data, subject_name: widget.subject_name,)
              : Center(child: CircularProgressIndicator());
        }



      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;


}
